require "./app/services/tokens_service"
require "./app/services/mail_service"
#ActionController::Parameters.action_on_unpermitted_parameters = :raise

class UsersController < ApplicationController
  include MailService
  include TokensService
  include ActionController::Cookies
  # POST auth/registration
  def registration
    if User.find_by(email: params[:email])
      raise "Error: User with given email elready exist"
    end
    per = user_params
    puts per
    @user = User.new per
    if @user.save
      MailService.sendActivationMail(@user)
      dto = { id: @user.id, email: @user.email, activated: @user.activated }
      @tokens = TokensService.generate_tokens(dto)
      TokensService.save_token(@user.id, @tokens[:refresh])
      cookies[:refresh_token] = { value: @tokens[:refresh], expires: Time.now + 3600 * 144, httponly: true }
      render json: { user: dto, tokens: @tokens }, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # GET /
  def index
    render json: { "erer": "rererer" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :organization_id, :password, :password_confirmation, person_name_attributes: [:family, :given_1, :given_2], contacts_attributes: [:value, :use],
    )
  end
end
