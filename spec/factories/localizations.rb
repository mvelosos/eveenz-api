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
    localizable { nil }
    latitude { '9.99' }
    longitude { '9.99' }
  end
end
