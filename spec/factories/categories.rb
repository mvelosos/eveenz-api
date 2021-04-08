# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
FactoryBot.define do
  factory :category do
    name { SecureRandom.hex(16) }
  end
end
