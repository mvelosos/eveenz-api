# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string
#  bio        :text
#  popularity :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :account do
    user { nil }
    name { 'MyString' }
    bio { 'MyText' }
    latitude { '9.99' }
    longitude { '9.99' }
    popularity { 1 }
  end
end
