#Implements the simplest and most common CRUD operations with models
class RestApi::V1::UniversalEntityController < RestApi::V1::ApplicationController
  before_action :authenticate_request
  before_action :prepare_model, only: [:index, :show, :create, :update, :destroy]
  before_action :find_record, only: [:show, :update, :destroy]

  # POST /REST_API/v1/model/:model_name
  # avaible options:
  #  :select for selection attributes of model,
  #  :render_options for to_json method
  #  :limit, :offset, :count for pagination support
  #  :q - option from runsack lib for supporting filtration
  #  :includes - for impatient loading of links(problem of N+1 query)
  def index
    @res = @model_class
    @res = @res.limit(params[:limit].to_i) if params[:limit]
    @res = @res.offset(params[:offset].to_i) if params[:offset]
    @res = @res.select(params[:select]) unless params[:select].blank?
    @res = @res.ransack(params[:q]).result unless params[:q].blank?
    if params[:count].blank?
      @res = @res.includes(params[:includes]) unless params[:includes].blank?
      r_options = {}
      if !params[:render_options].blank?
        r_options = render_options(params[:render_options].to_unsafe_h)
        render json: @res.all.to_json(r_options)
      else
        render json: @res.all
      end
    else
      render json: @res.count
    end
  end

  # POST /REST_API/v1/show/model/:model_name/:id
  # avaible options:
  #  :select for selection attributes of model,
  #  :render_options for to_json method
  def show
    @res = @model_class.select(params[:select]) unless params[:select].blank?
    r_options = {}
    if params[:render_options].blank?
      render json: @res
    else
      r_options = render_options(params[:render_options].to_unsafe_h)
      render json: @res.to_json(r_options), status: :ok
    end
  end

  # POST /REST_API/v1/model/:model_name/add
  def create
    @res = @model_class.new permitted_params
    if @res.save
      if @model_class.trackable?
        @res_a = Audit.new(guid: @res.guid, action: :added, table: params[:model_name],
                           severity: :success, user_id: @current_user[:data][:id], detail: @res.to_s)
        @res_a.save!
      end
      r_options = {}
      if params[:render_options].blank?
        render json: @res
      else
        r_options = render_options(params[:render_options].to_unsafe_h)
        render json: @res.to_json(r_options), status: :ok
      end
    else
      render json: { errors: @res.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /REST_API/v1/model/:model_name/:id
  def update
    audits = []
    if @model_class.trackable? && !params[:audits].blank?
      params[:audits].each do |audit|
        audits.push(Audit.new(guid: @res.guid, action: :updated, table: params[:model_name], field: audit[:field], after: audit[:after], before: audit[:before], severity: :success, summary: @res.to_s, detail: audit[:detail], user_id: @current_user[:data][:id]))
      end
    end
    if @res.update(permitted_params)
      @res.touch
      Audit.import audits if !audits.blank?
      r_options = {}
      find_record
      if params[:render_options].blank?
        render json: @res
      else
        r_options = render_options(params[:render_options].to_unsafe_h)
        render json: @res.to_json(r_options), status: :ok
      end
    else
      render json: { errors: @res.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /REST_API/v1/model/:model_name/:id
  def destroy
    @audit = Audit.new(guid: @res.guid, action: :removed, table: params[:model_name], severity: :success, detail: @res.to_s, user_id: @current_user[:data][:id]) if @model_class.trackable?
    if @res && @res.destroy
      @audit.save if @audit
      render json: @res
    else
      render json: { errors: @res.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(params[:model_name].to_sym).permit(@model_class.permitted_params)
  end

  def get_model_name
    params[:model_name] || controller_name.classify
  end

  def prepare_model
    model_name = get_model_name
    raise ApiError.new("Model class not present", :bad_request) if model_name.nil? || model_name.strip == ""
    @model_class = model_name.constantize
    raise ApiError.new("Model class is not ActiveRecord", :bad_request) unless @model_class < ActiveRecord::Base
  end

  def find_record
    @res = @model_class.find params[:id]
  end

  # create options for to_json render from params
  def render_options(options)
    options.reduce({}) do |result, (key, option)|
      if key == "include"
        result[:include] = option.reduce([]) do |sub_result, sub_option|
          if params[sub_option] && params[sub_option][:include]
            # use recursive rendering
            fix_option = { sub_option => render_options(params[sub_option].to_unsafe_h) }
          elsif params[sub_option]
            fix_option = { sub_option => params[sub_option].to_unsafe_h }
          else
            fix_option = sub_option
          end
          sub_result.push(fix_option)
        end
      else
        result = result.merge(key.to_sym => option)
      end
      result
    end if !options.blank?
  end
end
