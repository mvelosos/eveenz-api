require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  before do
    Account.reindex
    Event.reindex

    @current_user = FactoryBot.create(:user).reload
    authenticate_user_for_api(@current_user)

    @params = {
      query: ''
    }
  end

  describe 'GET #index' do
    context 'when data do not exists' do
      it 'should return an empty array' do
        get :index, params: @params
        expect(json).to have_key('data')
        expect(json['data']).to be_empty
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when accounts exists' do
      before do
        @accounts = FactoryBot.create_list(:user, 10).collect { |user| user&.account }
      end

      it 'should return array with accounts' do
        query = @accounts.first.user.username
        get :index, params: @params.merge(query: query)
        expect(json['data']).to_not be_empty
        expect(json['data'].first['type']).to eq('account')
        expect(json['data'].first['username']).to eq(query)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when events exists' do
      before do
        @events = FactoryBot.create_list(:event, 10)
      end

      it 'should return array with accounts' do
        query = @events.first.name
        get :index, params: @params.merge(query: query)
        expect(json['data']).to_not be_empty
        expect(json['data'].first['type']).to eq('event')
        expect(json['data'].first['name']).to eq(query)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
