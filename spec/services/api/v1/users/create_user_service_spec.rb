require 'rails_helper'

RSpec.describe Api::V1::Users::CreateUserService, type: :service do
  before do
    @user_params = {
      username: 'foobar',
      email: 'foobar@eveenz.com',
      password: 'foo123'
    }
  end

  context 'call create user service' do
    it 'should create a user and his associations' do
      user = Api::V1::Users::CreateUserService.call(@user_params)
      expect(user.present?).to be(true)
      expect(user.account.present?).to be(true)
      expect(user.account.account_setting.present?).to be(true)
      expect(user.account.address.present?).to be(true)
      expect(user.account.localization.present?).to be(true)
    end
  end
end
