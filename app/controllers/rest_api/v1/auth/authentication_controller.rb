class RestApi::V1::Auth::AuthenticationController < RestApi::V1::ApplicationController
  include ActionController::Cookies
  skip_before_action :authenticate_request, except: :index
  # POST REST_API/v1/auth/registration
  def registration
    if User.find_by(email: params[:user][:email])
      raise ApiError.new("Пользователь с таким email уже зарегистрирован", :unprocessable_entity)
    end
    @user = User.new user_params
    if @user.save
      ApplicationMailer.with(user_id: @user.id).confirmation_mail.deliver_later
      set_tokens
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
        redirect_to Rails.configuration.client_url + "/message/Аккаунт успешно активирован"
      end
    elsif @user.activated
      redirect_to Rails.configuration.client_url + "/message/Ссылка была использована ранее"
    else
      redirect_to Rails.configuration.client_url + "/message/Ссылка не действительна"
    end
  end

  # POST "REST_API/v1/auth/login"
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password]) && @user.activated
      set_tokens
    else
      raise ApiError.new("Неверный пароль или пользователь", :not_acceptable)
    end
  end

  # POST "REST_API/v1/auth/logout"
  def logout
    token = cookies[:refresh_token]
    token = JsonWebToken.remove_token(token)
    cookies.delete :refresh_token
    render json: { token: token }, status: :ok
  end

  # GET "REST_API/v1/auth/refresh" обновляем токен
  def refresh
    refresh_token = cookies[:refresh_token]
    raise ApiError.new("Ошибка авторизации 1", :unauthorized) if refresh_token.blank?
    user_data = JsonWebToken.validate_token(refresh_token, JsonWebToken::REFRESH_SECRET)
    raise ApiError.new("Ошибка авторизации 2", :unauthorized) unless user_data
    if Token.find_by(refresh_token: refresh_token)
      @user = User.find(user_data["data"]["id"])
      set_tokens
    else
      raise ApiError.new("Ошибка авторизации 3", :unauthorized)
    end
  end

  # GET "REST_API/v1/auth/organizations"
  # получаем список медорганизаций для формы регистрации
  def get_organizations
    # только ID и короткое наименование
    render json: { "organizations": Organization.select(:id, :name).all }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :organization_id, :password, :password_confirmation, :roles, person_name_attributes: [:family, :given_1, :given_2], contacts_attributes: [:value, :use],
    )
  end

  def set_tokens
    dto = { id: @user.id, email: @user.email, roles: @user.roles, organization_id: @user.organization_id, activated: @user.activated, logged: @user.updated_at }
    @user.login_times = @user.login_times ? @user.login_times + 1 : 0
    if @user.save
      tokens = JsonWebToken.generate_tokens(dto)
      JsonWebToken.save_token(@user.id, tokens[:refresh])
      cookies[:refresh_token] = { value: tokens[:refresh], expires: 144.hour, httponly: true }
      render json: { user: dto, tokens: tokens }, status: :ok
    else
      raise ApiError.new("Ошибка авторизации 4", :unauthorized)
    end
  end
end
