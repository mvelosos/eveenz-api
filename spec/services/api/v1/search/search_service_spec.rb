require 'rails_helper'

RSpec.describe Api::V1::Search::SearchService, type: :service do
  before do
    @user = FactoryBot.create(:user)
    @accounts = FactoryBot.create_list(:user, 10).collect { |user| user&.account }
    @events = FactoryBot.create_list(:event, 10, name: SecureRandom.hex(10))
  end

  context 'call search service' do
    it 'should return hash with data' do
      search_result = Api::V1::Search::SearchService.call(@user.account)
      expect(search_result).to have_key('data')
    end

    it 'should return account by username' do
      account = @accounts.first
      params = {
        query: account.user.username
      }
      search_result = Api::V1::Search::SearchService.call(@user.account, params)
      expect(search_result['data'].first['username']).to eq(account.user.username)
      expect(search_result['data'].first['type']).to eq('account')
    end

    it 'should return account by name' do
      account = @accounts.first
      params = {
        query: account.name
      }
      search_result = Api::V1::Search::SearchService.call(@user.account, params)
      expect(search_result['data'].first['name']).to eq(account.name)
      expect(search_result['data'].first['type']).to eq('account')
    end

    it 'should return event by name' do
      event = @events.first
      params = {
        query: event.name
      }
      search_result = Api::V1::Search::SearchService.call(@user.account, params)
      expect(search_result['data'].first['name']).to eq(event.name)
      expect(search_result['data'].first['type']).to eq('event')
    end
  end
end
