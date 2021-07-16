require "./app/services/tokens_service"

class RestApi::V1::Auth::UsersController < RestApi::V1::ApplicationController
  include TokensService
  include ActionController::Cookies
  #include ActionController::BadRequest

  # POST REST_API/v1/auth/registration
  def registration
    if User.find_by(email: params[:user][:email])
      raise ApiError.new("Пользователь с таким email уже зарегистрирован", :unprocessable_entity)
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

  # GET REST_API/v1/auth/activation
  def activation
    @user = User.where(activation_link: params[:link]).first
    if @user && !@user.activated
      @user.activated = true
      if @user.save
        ApplicationMailer.with(email: @user.email, to: Rails.configuration.admin_mail).welcome_mail.deliver_later
        ApplicationMailer.with(email: @user.email, to: @user.email).welcome_mail.deliver_later
        redirect_to Rails.configuration.client_url + "/messages?value=Аккаунт успешно активирован"
      end
    elsif @user.activated
      redirect_to Rails.configuration.client_url + "/messages?value=Ссылка была использована ранее"
    else
      redirect_to Rails.configuration.client_url + "/messages?value=Ссылка не действительна"
    end
  end

  # POST "REST_API/v1/auth/login"
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      dto = { id: @user.id, email: @user.email, organization_id: @user.organization_id }
      @tokens = TokensService.generate_tokens(dto)
      TokensService.save_token(@user.id, @tokens[:refresh])
      cookies[:refresh_token] = { value: @tokens[:refresh], expires: Time.now + 3600 * 144, httponly: true }
      render json: { user: dto, tokens: @tokens }, status: :ok
    else
      raise ApiError.new("Неверный пароль или пользователь", :unauthorized)
    end
  end

  # POST "REST_API/v1/auth/logout"
  def logout
    token = cookies[:refresh_token]
    token = TokensService.remove_token(token)
    cookies.delete :refresh_token
    render json: { token: token }, status: :ok
  end

  # GET auth/
  def index
    render json: { "erer": "rererer" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :organization_id, :password, :password_confirmation, :roles, person_name_attributes: [:family, :given_1, :given_2], contacts_attributes: [:value, :use],
    )
  end
end
