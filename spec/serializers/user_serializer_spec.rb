# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  email           :string
#  username        :string
#  password_digest :string
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#  verified        :boolean          default(TRUE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#
require 'rails_helper'

describe UserSerializer, type: :serializer do
  before do
    @user = FactoryBot.create(:user)
  end

  let(:resource_key) { :user }
  let(:resource) { @user }

  let(:expected_fields) do
    %i[
      username
      email
      provider
      createdAt
    ].sort
  end
end
