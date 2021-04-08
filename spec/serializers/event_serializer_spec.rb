# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  account_id    :bigint
#  name          :string
#  description   :text
#  active        :boolean          default(TRUE)
#  privacy       :string
#  start_date    :date
#  end_date      :date
#  start_time    :time
#  end_time      :time
#  undefined_end :boolean          default(FALSE)
#  external_url  :string
#  minimum_age   :integer
#  tags          :text             default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  discarded_at  :datetime
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
      privacy
      startDate
      endDate
      startTime
      endTime
      hostAvatar
      hostName
      address
      localization
      undefinedEnd
      externalUrl
      minimumAge
    ].sort
  end
end
