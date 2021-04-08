require 'rails_helper'

RSpec.describe Api::V1::Auth::FacebookLoginService, type: :service do
  before do
    User.destroy_all
    @fb_access_token = retrieve_facebook_test_token
  end

  context 'call facebook login service' do
    it 'should create or return a existing user' do
      user = Api::V1::Auth::FacebookLoginService.call(@fb_access_token)
      expect(user).to be_valid
    end
  end
end
