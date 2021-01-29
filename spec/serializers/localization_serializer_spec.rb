# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
require 'rails_helper'

describe LocalizationSerializer, type: :serializer do
  before do
    @localization = FactoryBot.create(:account_localization)
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
