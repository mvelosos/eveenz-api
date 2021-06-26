require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @account = FactoryBot.create(:user).account
    authenticate_user_for_api(@current_user)
  end

  describe 'GET #index' do
    context 'when notification exists' do
      before do
        FactoryBot.create_list(:notification, 5, account: @current_user.account, notifiable: @account)
      end

      it 'should return an array of notificications with status ok' do
        get :index
        expect(json).to have_key('notifications')
        expect(json['notifications'].count).to eq(5)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when notifications does not exists' do
      it 'should return an empty array with status ok' do
        get :index
        expect(json).to have_key('notifications')
        expect(json['notifications'].empty?).to eq(true)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
