require 'rails_helper'

describe ApiUuidSuccessSerializer, type: :serializer do
  before do
    @user = FactoryBot.create(:user)
  end

  let(:resource_key) { :user }
  let(:resource) { @user }
  let(:serializer_name) { 'ApiUuidSuccess' }

  let(:expected_fields) do
    %i[
      uuid
    ].sort
  end
end
