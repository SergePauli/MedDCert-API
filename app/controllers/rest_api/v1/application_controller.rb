class RestApi::V1::ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  ## API Universal Exception Handling
  class ApiError < StandardError
    def initialize(message, status)
      super(message)
      @status = status
    end

    attr_reader :status
  end

  rescue_from ApiError, :with => :api_error

  def api_error(exception)
    render json: { errors: [exception.message] }, status: exception.status
  end

  def authenticate_request
    header = request.headers["Authorization"]
    raise ApiError.new("Не авторизовано", :unauthorized) unless header
    header = header.split(" ").last
    @current_user = JsonWebToken.validate_token(header, JsonWebToken::ACCESS_SECRET)
    raise ApiError.new("Не авторизовано", :unauthorized) unless @current_user
  end
end
