# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  addressable_id   :bigint
#  street           :string
#  number           :string
#  complement       :string
#  neighborhood     :string
#  zip_code         :string
#  city             :string
#  state            :string
#  country          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  discarded_at     :datetime
#

FactoryBot.define do
  factory :address do
    addressable { nil }
    street { 'MyString' }
    number { 'MyString' }
    complement { 'MyString' }
    neighborhood { 'MyString' }
    zip_code { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    country { 'MyString' }
  end
end
