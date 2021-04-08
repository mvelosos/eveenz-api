require 'rails_helper'

RSpec.describe Api::V1::MeController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user).reload
    authenticate_user_for_api(@current_user)
  end

  describe 'GET #show' do
    context 'when user request his own account' do
      it 'should return his own data' do
        get :show
        expect(json).to have_key('account')
        expect(json['account']['uuid']).to_not be_nil
        expect(json['account']['username']).to_not be_nil
        expect(json['account']['popularity']).to_not be_nil
        expect(json['account']['events']).to_not be_nil
        expect(json['account']['following']).to_not be_nil
        expect(json['account']['followers']).to_not be_nil
        expect(json['account']['avatarUrl']).to_not be_nil
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when user updates his own account with valid params' do
      it 'should return his own data' do
        get :update, params: { account: { name: 'foobar' } }
        expect(json['me']['id']).to eq(@current_user.account.id)
        expect(@current_user.account.name).to eq('foobar')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user updates his own account with invalid params' do
      it 'should return error with nil username' do
        get :update, params: { account: { userAttributes: { username: nil } } }
        expect(json['error']).to_not be_empty
        expect(response).to have_http_status(:not_acceptable)
      end

      it 'should return error with nil email' do
        get :update, params: { account: { userAttributes: { email: nil } } }
        expect(json['error']).to_not be_empty
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end

  describe 'GET #mine' do
    context 'when user does not has created events' do
      it 'should return an empty array' do
        get :mine
        expect(json['events']).to be_empty
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user has created events' do
      it 'should return an array of events' do
        @events = FactoryBot.create_list(:event, 5, account: @current_user.account)
        get :mine
        expect(json['events'].count).to eq(5)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #confirmed' do
    context 'when user does not follow any event' do
      it 'should return an empty array' do
        get :confirmed
        expect(json['events']).to be_empty
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user follows events' do
      before do
        @events = FactoryBot.create_list(:event, 12, account: @current_user.account)
        @events.each do |event|
          @current_user.account.follow(event)
        end
      end

      it 'should return an empty array' do
        get :confirmed
        expect(json['events'].count).to eq(12)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
