#Implements the simplest and most common CRUD operations with models
class RestApi::V1::UniversalEntityController < RestApi::V1::ApplicationController
  before_action :authenticate_request
  before_action :prepare_model, only: [:index, :show, :create, :update, :destroy]
  before_action :find_record, only: [:show, :update, :destroy]
  after_action :action_result, only: [:create, :update, :destroy]

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
    @res = @res.count unless params[:count].blank?
    @res = @res.includes(params[:includes]) unless params[:includes].blank?
    r_options = {}
    if !params[:render_options].blank?
      r_options = render_options(params[:render_options])
      render json: @res.to_json(r_options)
    else
      render json: @res
    end
  end

  # POST /REST_API/v1/model/:model_name/:id
  # avaible options:
  #  :select for selection attributes of model,
  #  :render_options for to_json method
  def show
    @res = @model_class.select(params[:select]) unless params[:select].blank?
    if params[:render_options].blank?
      render json: @res
    else
      r_options = render_options(params[:render_options])
      render json: @res.to_json(r_options)
    end
  end

  # POST /REST_API/v1/model/:model_name/add
  def create
    @res = @model_class.create(permitted_params)
  end

  # PUT /REST_API/v1/model/:model_name/:id
  def update
    @res.update(permitted_params)
  end

  # DELETE /REST_API/v1/model/:model_name/:id
  def destroy
    @res.destroy
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
    @model_class = model_name.capitalize.constantize
    raise ApiError.new("Model class is not ActiveRecord", :bad_request) unless @model_class < ActiveRecord::Base
  end

  def find_record
    @res = @model_class.find(params[@model_class.primary_key.to_sym])
  end

  def action_result
    raise ApiError.new(@res.errors[:base].to_s, :bad_request) unless @res.errors[:base].empty?
    render json: @res
  end

  # create options for to_json render from params
  def render_options(options)
    r_options = {}
    r_options = r_options.merge(only: options[:only]) if options[:only]
    r_options = r_options.merge(except: options[:except]) if options[:except]
    if options[:include]
      r_options[:include] = []
      options[:include].each do |option|
        if params[option] && params[option][:include]
          # use recursive rendering
          fix_option = { option => render_options(params[option]) }
        elsif params[option]
          fix_option = { option => params[option] }
        else
          fix_option = option
        end
        r_options[:include].push(fix_option)
      end
    end
    r_options
  end
end
