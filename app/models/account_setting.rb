# == Schema Information
#
# Table name: account_settings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint
#  distance_radius :float            default(10.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  unit            :string           default("km"), not null
#

class AccountSetting < ApplicationRecord
  belongs_to :account

  validates :distance_radius, presence: true
  validates :unit,            presence: true
  validates :unit,            inclusion: %w[km mi]
end
