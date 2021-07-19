class RestApi::V1::Auth::PassRecoveryController < RestApi::V1::ApplicationController
  skip_before_action :authenticate_request

  # POST REST_API/v1/auth/renew_link
  # generating password renew link and send to user via email
  def renew_link
    get_user
    ApplicationMailer.with(email: @user.email, link: @user.activation_link).pass_renew_mail.deliver_later
    render json: { message: "link sended" }, status: :ok
  end

  # POST REST_API/v1/auth/pwd_renew
  # password change
  def pwd_renew
    @user = User.find_by(activation_link: params[:activation_link])
    raise ApiError.new("Неверный код", :unprocessable_entity) unless @user
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      render json: { message: "password changed" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def get_user
    raise ApiError.new("Не указан email", :bad_request) if params[:email].blank?
    @user = User.find_by(email: params[:email])
    raise ApiError.new("Пользователь с таким email не зарегистрирован", :unprocessable_entity) unless @user
  end
end
