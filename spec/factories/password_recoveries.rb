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
FactoryBot.define do
  factory :password_recovery do
    user { FactoryBot.create(:user) }
    code { 6.times.map { rand(0..9) }.join }
    discarded_at { nil }
  end
end
