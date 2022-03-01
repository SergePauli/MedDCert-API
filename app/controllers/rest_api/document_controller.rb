class RestApi::DocumentController < ActionController::Base
  before_action :prepare_data

  ## API CDA Universal Exception Handling
  class ApiCdaError < StandardError
    def initialize(message, status)
      super(message)
      @status = status
    end

    attr_reader :status
  end

  rescue_from ApiCdaError, :with => :api_error

  def api_error(exception)
    render xml: { errors: [exception.message] }, status: exception.status
  end

  private

  def find_record
    @certificate = Certificate.find params[:id]
  end

  def prepare_data
    find_record
  end
end
