require "./app/services/tokens_service"

class UsersController < ApplicationController
  include TokensService
  include ActionController::Cookies

  # POST auth/registration
  def registration
    if User.find_by(email: params[:email])
      raise "Error: User with given email elready exist"
    end
    @user = User.new user_params
    if @user.save
      dto = { id: @user.id, email: @user.email, organization_id: @user.organization_id }
      ApplicationMailer.with(user_id: @user.id).confirmation_mail.deliver_later
      @tokens = TokensService.generate_tokens(dto)
      TokensService.save_token(@user.id, @tokens[:refresh])
      cookies[:refresh_token] = { value: @tokens[:refresh], expires: Time.now + 3600 * 144, httponly: true }
      render json: { user: dto, tokens: @tokens }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET auth/activation
  def activation
    @user = User.where(activation_link: params[:link]).first
    if @user && !@user.activated
      @user.activated = true
      if @user.save
        ApplicationMailer.with(email: @user.email, to: Rails.configuration.admin_mail).welcome_mail.deliver_later
        ApplicationMailer.with(email: @user.email, to: @user.email).welcome_mail.deliver_later
        render html: "<h1>Аккаунт успешно активирован</h1>"
      end
    elsif @user.activated
      render html: "<h1>Данный аккаунт был активирован ранее</h1>"
    else
      render html: "<h1>Ссылка не действительна</h1>"
    end
  end

  # GET auth/
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
