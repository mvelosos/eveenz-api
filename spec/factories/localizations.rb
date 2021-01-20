# == Schema Information
#
# Table name: localizations
#
#  id               :bigint           not null, primary key
#  localizable_type :string
#  localizable_id   :bigint
#  latitude         :decimal(11, 8)
#  longitude        :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  discarded_at     :datetime
#

FactoryBot.define do
  factory :localization do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    factory :account_localization do
      localizable { FactoryBot.create(:account) }
    end

    factory :event_localization do
      localizable { FactoryBot.create(:event) }
    end
  end
end
