# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notifiable_type   :string           not null
#  notifiable_id     :bigint           not null
#  notification_type :string
#  viewed            :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  discarded_at      :datetime
#  account_id        :bigint           not null
#
require 'rails_helper'

describe NotificationSerializer, type: :serializer do
  before do
    @notification = FactoryBot.create(:notification)
    @account = FactoryBot.create(:user).account
  end

  let(:resource_key) { :notification }
  let(:resource) { @notification }
  let(:serializer_options) { { scope: @account.user } }

  let(:expected_fields) do
    %i[
      notificationType
      follower
      followedByMe
      createdAt
    ].sort
  end
end
