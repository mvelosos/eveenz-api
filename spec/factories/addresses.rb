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
    street { Faker::Address.street_name }
    number { Faker::Number.number(digits: 4) }
    complement { "APT #{Faker::Number.number(digits: 3)}" }
    neighborhood { Faker::Address.community }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }

    factory :account_address do
      addressable { FactoryBot.create(:account) }
    end

    factory :event_address do
      addressable { FactoryBot.create(:event) }
    end
  end
end
