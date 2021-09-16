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

describe AccountFollowSerializer, type: :serializer do
  # before do
  #   @account = FactoryBot.create(:user).account
  # end

  # let(:resource_key) { :account }
  # let(:resource) { @account }
  # let(:serializer_name) { 'AccountFollowNotification' }

  # let(:expected_fields) do
  #   %i[
  #     uuid
  #     name
  #     username
  #     avatarUrl
  #   ].sort
  # end
end
