require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  before do
    # We need to reindex and refresh index to make search works with Elasticsearch
    Account.reindex
    Event.reindex

    @current_user = FactoryBot.create(:user).reload
    @accounts = FactoryBot.create_list(:user, 10).collect { |user| user&.account }
    @events = FactoryBot.create_list(:event, 10, name: 'foobar event')

    Account.search_index.refresh
    Event.search_index.refresh

    authenticate_user_for_api(@current_user)
  end

  describe 'GET #index' do
    context 'when data do not exists' do
      it 'should return an empty array' do
        get :index, params: { query: '' }
        expect(json).to have_key('data')
        expect(json['data']).to be_empty
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when accounts exists' do
      it 'should return data with accounts' do
        query = @accounts.first.user.username
        get :index, params: { query: query[0..-2] }
        expect(json['data']).to_not be_empty
        expect(json['data'].first['type']).to eq('account')
        expect(json['data'].first['username']).to eq(query)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when events exists' do
      it 'should return data with events' do
        query = 'foobar event'
        get :index, params: { query: query[0..-2] }
        expect(json['data']).to_not be_empty
        expect(json['data'].first['type']).to eq('event')
        expect(json['data'].first['name']).to eq('foobar event')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
