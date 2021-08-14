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
require 'rails_helper'

describe AccountSettingSerializer, type: :serializer do
  before do
    @account_setting = FactoryBot.create(:user).account.account_setting
  end

  let(:resource_key) { :accountSetting }
  let(:resource) { @account_setting }
  let(:serializer_name) { 'AccountSetting' }

  let(:expected_fields) do
    %i[
      distanceRadius
      unit
      private
    ].sort
  end
end
