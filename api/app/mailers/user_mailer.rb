class UserMailer < ApplicationMailer
  default from: 'dontreply@example.com'

  def forgot_password(user)
    @user = user
    mail(to: user.email, subject: 'Forgot your password')
  end

  def update_password(user)
    @user = user
    mail(to: user.email, subject: 'Password updated')
  end
end