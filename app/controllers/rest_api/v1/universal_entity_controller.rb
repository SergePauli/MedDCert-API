#Implements the simplest and most common CRUD operations with models
class RestApi::V1::UniversalEntityController < RestApi::V1::ApplicationController
  before_action :authenticate_request
  before_action :prepare_model, only: [:index, :show, :create, :update, :destroy]
  before_action :find_record, only: [:show, :update, :destroy]
  after_action :action_result, only: [:create, :update, :destroy]

  def index
    @res = @model_class
    @res = @res.limit(params[:limit].to_i) if params[:limit]
    @res = @res.offset(params[:offset].to_i) if params[:offset]
    @res = @res.select(permitted_params) if !params[:select].blank?
    @res = @res.ransack(params[:q]).result
    if !params[:render_options].blank?
      resultes_arr = Array.new
      @resultes = @res.includes JSON.parse params[:includes] if !params[:includes].blank?
      @resultes.each do |r|
        resultes_arr.push r.as_json JSON.parse params[:render_options]
      end
      render json: { status: 200, data: resultes_arr }
    else
      @res = @res.count if !params[:count].blank?
      render json: { status: 200, data: @res }
    end
  end

  def show
    @res = @model_class.select(permitted_params) if !params[:select].blank?
    render json: { status: 200, data: @res }
  end

  def create
    @res = @model_class.create(permitted_params)
  end

  def update
    @res.update(permitted_params)
  end

  def destroy
    @res.destroy
  end

  private

  def permitted_params
    if params[:select]
      params[:select].each do |field|
        field.to_sym
      end
    else
      params.require(params[:model_name].to_sym).permit(@model_class.permitted_params)
    end
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
    render json: { status: 200, data: @res }
  end
end
