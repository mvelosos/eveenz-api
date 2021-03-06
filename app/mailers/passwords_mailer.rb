class PasswordsMailer < ApplicationMailer
  default from: 'Eveenz <noreply@eveenz.com>'

  def send_recovery_code(user)
    @user = user
    @password_recovery = user.password_recovery
    mail(to: @user.email, subject: 'Instruções para recuperação de senha!')
  end

  def password_successfully_updated(user)
    @user = user
    mail(to: @user.email, subject: 'Sua senha foi alterada com sucesso!')
  end
end
