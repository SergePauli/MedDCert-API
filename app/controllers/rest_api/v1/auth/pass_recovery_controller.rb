class RestApi::V1::Auth::PassRecoveryController < RestApi::V1::ApplicationController
  skip_before_action :authenticate_request
  before_action :get_user

  # POST REST_API/v1/auth/renew_link
  # generating password renew link and send to user via email
  def renew_link
    ApplicationMailer.with(email: @user.email, link: @user.activation_link).pass_renew_mail.deliver_later
  end

  # POST REST_API/v1/auth/pwd_renew
  # password change
  def pwd_renew
    if @user.update params.require(:user).permit(
      :email, :password, :password_confirmation
    )
      render json: { message: "password changed" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def get_user
    raise ApiError.new("Не указан email", :bad_request) unless params[:email].blank?
    @user = User.find_by(email: params[:email])
    raise ApiError.new("Пользователь с таким email не зарегистрирован", :unprocessable_entity) unless @user
  end
end
