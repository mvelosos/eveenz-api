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
require 'rails_helper'

describe LocalizationSerializer, type: :serializer do
  before do
    @localization = FactoryBot.create(:localization, localizable: FactoryBot.create(:user).account)
  end

  let(:resource_key) { :localization }
  let(:resource) { @localization }

  let(:expected_fields) do
    %i[
      latitude
      longitude
    ].sort
  end
end
