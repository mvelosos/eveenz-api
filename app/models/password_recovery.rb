# == Schema Information
#
# Table name: password_recoveries
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  code         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#  token        :string
#
class PasswordRecovery < ApplicationRecord
  include Discard::Model

  belongs_to :user

  validates :code, length: { minimum: 6, maximum: 6 }, allow_nil: false, on: :save

  before_create :generate_recovery_code

  def generate_recovery_code
    generated_code = nil

    loop do
      generated_code = random_code
      break if PasswordRecovery.find_by_code(generated_code).nil?
    end

    self.code = generated_code
  end

  def random_code
    6.times.map { rand(0..9) }.join
  end
end
