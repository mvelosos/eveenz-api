require 'rails_helper'

RSpec.describe Api::V1::Auth::FacebookLoginService, type: :service do
  before do
    User.destroy_all
    # This token was generate at Facebook Developers. Please, do not change.
    @fb_access_token = 'EAAJXl0kUqRkBAMhOezLln0GV9qh2mwwFuXb8FStA4dO3UAoYnsNH6fP9LXXdeD6GSHkRZCi48W1bwISgbVn6pS3RK'\
                       'Hko1Cca7ctFDTASt7EIFZCSrAMYTctZA0TLZCUhEVXetHjXkSOol6kqd5tESqpaU1KaRgWJK5fkZCxqvK8H6RZA7To9'\
                       'gE94hcVExImWukLQ4saOIjJQZDZD'.freeze
  end

  # context 'call facebook login service' do
  #   it 'should create or return a existing user' do
  #       user = Api::V1::Auth::FacebookLoginService.new(@fb_access_token).login
  #       expect(user).to be_valid
  #   end
  # end
end
