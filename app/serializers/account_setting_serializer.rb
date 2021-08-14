# == Schema Information
#
# Table name: account_settings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint
#  distance_radius :float            default(10.0), not null
#  unit            :string           default("km"), not null
#  private         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#
class AccountSettingSerializer < ActiveModel::Serializer
  attributes :distance_radius,
             :unit,
             :private
end
