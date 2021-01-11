# Preview all emails at http://localhost:3000/rails/mailers/passwords_mailer
class PasswordsMailerPreview < ActionMailer::Preview
  def send_recovery_code
    PasswordsMailer.send_recovery_code(User.first)
  end
end
