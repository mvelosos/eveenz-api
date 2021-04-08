# == Schema Information
#
# Table name: account_settings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint
#  distance_radius :float            default(10.0), not null
#  unit            :string           default("km"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#

FactoryBot.define do
  factory :account_setting do
    distance_radius { 1.5 }
    unit { 'km' }
  end
end
