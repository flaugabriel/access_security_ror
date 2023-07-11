class UserMailer < ApplicationMailer
  default from: 'dontreply@example.com'

  def forgot_password(user)
    @user = user
    mail(to: user.email, subject: 'Esqueceu sua senha?')
  end

  def update_password(user)
    @user = user
    mail(to: user.email, subject: 'Senha atualizada!')
  end

  def login_attempt_notification(user)
    @user = user
    mail(to: user.email, subject: 'Notificação de login em sua conta.')
  end 
end