require 'rails_helper'

RSpec.describe Api::V1::Auth::FacebookLoginService, type: :service do
  before do
    User.destroy_all
    # This token was generate at Facebook Developers. Please, do not change.
    @fb_access_token = 'EAAJXl0kUqRkBACGRlnvgZBopGyycUVZBak89BzIIU16IXuPnoujNPai9GzswRVyV1u4m4gZAcQTm0TgV1sZB7lb2sG3r4JZAZCRf'\
                       'WYll2BO65fVUKLLK0pYRwdd4twTIbUK57g9QtwZCBJyfRBXpzlZAK2NJd0zYo20rbR7sJWo9MPl0lxKCPvRBdnWeola9V3bKezvd'\
                       'Pj7WCQZDZD'.freeze
  end

  context 'call facebook login service' do
    it 'should create or return a existing user' do
      user = Api::V1::Auth::FacebookLoginService.new(@fb_access_token).login
      expect(user).to be_valid
    end
  end
end
