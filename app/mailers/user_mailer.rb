class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset_email(password_reset, user)
    @url = new_password_users_url(:q => password_reset.auth_token)
    mail(to: user.email, subject: 'Reset your password')
  end
end
