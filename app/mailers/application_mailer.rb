class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.from_mail
  layout "mailer"

  def confirmation_mail
    @user = User.find(params[:user_id])
    if @user
      @name = @user.name
      @email = @user.email
      @org_name = @user.organization_name
      @url = "#{Rails.configuration.base_url}/REST_API/v1/auth/activate/#{@user.activation_link}"
      mail(to: Rails.configuration.admin_mail, subject: "Запрос на активацию аккаунта МедСС")
    end
  end

  def welcome_mail
    @email = params[:email]
    mail(to: params[:to], subject: "МедСС: аккаунт был активирован")
  end
end
