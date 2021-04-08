require 'rails_helper'

RSpec.describe Api::V1::Auth::AuthService, type: :service do
  before do
    @user = FactoryBot.create(:user, username: 'eveenz', email: 'eveenz@eveenz.com', password: 'eveenz123')
  end

  context 'call auth service' do
    it 'should return auth user' do
      auth_user = Api::V1::Auth::AuthService.call(@user)
      expect(auth_user['username']).to eq('eveenz')
      expect(auth_user['createdAt']).to_not be_nil
      expect(auth_user['token']).to_not be_nil
      expect(auth_user['tokenType']).to eq('Bearer')
      expect(auth_user['exp']).to_not be_nil
      expect(auth_user['provider']).to eq('api')
    end
  end
end
