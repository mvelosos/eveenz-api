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

describe EventSerializer, type: :serializer do
  before do
    @event = FactoryBot.create(:event)
  end

  let(:resource_key) { :event }
  let(:resource) { @event }

  let(:expected_fields) do
    %i[
      uuid
      name
      description
      images
      kind
      date
      time
      hostAvatar
      hostName
      address
      localization
    ].sort
  end
end
