require 'rails_helper'

RSpec.describe Api::V1::Auth::FacebookLoginService, type: :service do
  before do
    User.destroy_all
    # This token was generate at Facebook Developers. Please, do not change.
    @fb_access_token = 'EAAJXl0kUqRkBAFbO8LfuZBup0DiMbR6SCnljqmLXSIiETRYHbNp0rXAaQxeRnaFgslwB6UJtHalvpmGdZBZBeCsLmwkuh497wZC'\
                       '1rqymrCIzLg8FT8uSwDhKyqTv2fHNZB4ogKnTwhu6EV8R4cTbZAaxeP3cYJtOM4Xu19TmPn72E5tyy5gcoApiMbLoUTcOBe0VTzV'\
                       'iIHLQZDZD'.freeze
  end

  context 'call facebook login service' do
    it 'should create or return a existing user' do
      user = Api::V1::Auth::FacebookLoginService.new(@fb_access_token).login
      expect(user).to be_valid
    end
  end
end
