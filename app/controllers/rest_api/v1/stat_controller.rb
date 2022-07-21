#Implements the user's statistic module
class RestApi::V1::StatController < RestApi::V1::ApplicationController
  before_action :authenticate_request

  def index
    logged = Time.parse(@current_user[:data][:logged])
    organization_id = @current_user[:data][:organization_id]
    count = 0
    selection = Certificate.where(custodian_id: organization_id)
    result = { created: 0, updated: 0, replaced: 0, issued: 0, count: 0 }
    result[:created] = selection.where("created_at > ?", logged).where("issue_date IS null").count
    count += result[:created]
    result[:updated] = selection.where("updated_at > ?", logged).count
    count += result[:updated]
    result[:replaced] = selection.where("not number_prev is null").where("created_at > ?", logged).count
    count += result[:replaced]
    result[:issued] = selection.where("issue_date > ?", logged).count
    count += result[:issued]
    result[:count] = count
    result[:logged] = logged
    render json: result
  end
end
