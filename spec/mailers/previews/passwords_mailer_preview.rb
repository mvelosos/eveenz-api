# Preview all emails at http://localhost:3000/rails/mailers/passwords_mailer
class PasswordsMailerPreview < ActionMailer::Preview
  def send_recovery_code
    user = User.first
    user.create_password_recovery!
    PasswordsMailer.send_recovery_code(user)
  end

  def password_successfully_updated
    PasswordsMailer.password_successfully_updated(User.first)
  end
end
