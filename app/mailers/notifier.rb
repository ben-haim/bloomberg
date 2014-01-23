class Notifier < ActionMailer::Base
  default from: "john@contego.com"

  def send_alert_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Alert for Your Investment Portfolio")
  end
end
