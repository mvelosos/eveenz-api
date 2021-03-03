class PasswordsMailer < ApplicationMailer
  default from: 'Eveenz <noreply@eveenz.com>'

  def send_recovery_code(user)
    @user = user
    @password_recovery = user.password_recovery
    mail(to: @user.email, subject: 'Instruções para atualização de senha!')
  end
end
