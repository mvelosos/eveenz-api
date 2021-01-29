require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @account = FactoryBot.create(:user, username: 'foo.bar').account
    authenticate_user_for_api(@current_user)
  end

  context 'GET #show' do
    context 'with valid params' do
      it 'should return a account' do
        get :show, params: { username: 'foo.bar' }
        expect(json['account']['username']).to eq('foo.bar')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'should return error message' do
        invalid_username = SecureRandom.hex(3)
        get :show, params: { username: invalid_username }
        expect(json['errors']).to be_truthy
        expect(json['errors']).to match(/User #{invalid_username} not found/)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  context 'GET #followers' do
    before do
      followers_accounts = FactoryBot.create_list(:account, 8)
      followers_accounts.each do |account|
        account.follow(@account)
      end
    end

    it 'should return all folowers to account' do
      get :followers, params: { username: 'foo.bar' }
      expect(json['accounts'].length).to eq(8)
    end
  end

  context 'GET #following' do
    before do
      following_accounts = FactoryBot.create_list(:account, 4)
      following_accounts.each do |account|
        @account.follow(account)
      end
    end

    it 'should return all followings accounts' do
      get :following, params: { username: 'foo.bar' }
      expect(json['accounts'].length).to eq(4)
    end
  end
end
