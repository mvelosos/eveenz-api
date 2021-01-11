class UserRecoveryPasswordJob < ApplicationJob
  queue_as :mailers

  def perform(user_id)
    user = User.find(user_id)
    user.create_password_recovery!
    PasswordsMailer.send_recovery_code(user).deliver_later
  end
end
