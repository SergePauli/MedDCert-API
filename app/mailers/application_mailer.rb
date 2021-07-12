class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def confirmation_email
    @user = params[:user]
    @url = params[:activation_link]
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end
end
