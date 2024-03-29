require 'rails_helper'

describe ApiSuccessSerializer, type: :serializer do
  before do
    @user = FactoryBot.create(:user)
  end

  let(:resource_key) { :user }
  let(:resource) { @user }
  let(:serializer_name) { 'ApiSuccess' }

  let(:expected_fields) do
    %i[
      id
    ].sort
  end
end
