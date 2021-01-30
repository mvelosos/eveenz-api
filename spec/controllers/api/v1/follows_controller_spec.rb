require 'rails_helper'

RSpec.describe Api::V1::FollowsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)
    @account = FactoryBot.create(:user).account.reload
    @event = FactoryBot.create(:event).reload
    authenticate_user_for_api(@current_user)
  end

  describe 'POST #follow_account' do
    context 'when current user follows another user' do
      it 'should follow successfuly' do
        post :follow_account, params: { uuid: @account.uuid }
        expect(json['result']).to eq('following')
        expect(@current_user.account.following?(@account)).to be(true)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when current user follows the same user again' do
      it 'should return unfollow' do
        @current_user.account.follow(@account)
        post :follow_account, params: { uuid: @account.uuid }
        expect(json['result']).to eq('following')
        expect(@current_user.account.following?(@account)).to be(true)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'POST #unfollow_account' do
    context 'when current user unfollow another user' do
      it 'should unfollow successfuly' do
        @current_user.account.follow(@account)
        post :unfollow_account, params: { uuid: @account.uuid }
        expect(json['result']).to eq('unfollowing')
        expect(@current_user.account.following?(@account)).to be(false)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when current user unfollow a unfollowed user' do
      it 'should return unfollow' do
        post :unfollow_account, params: { uuid: @account.uuid }
        expect(json['result']).to eq('unfollowing')
        expect(@current_user.account.following?(@account)).to be(false)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #follow_event' do
    context 'when current user follows an event (confirm presence)' do
      it 'should follow successfuly' do
        post :follow_event, params: { uuid: @event.uuid }
        expect(json['result']).to eq('following')
        expect(@current_user.account.following?(@event)).to be(true)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when current user follows the event again' do
      it 'should return unfollow' do
        @current_user.account.follow(@event)
        post :follow_event, params: { uuid: @event.uuid }
        expect(json['result']).to eq('following')
        expect(@current_user.account.following?(@event)).to be(true)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'POST #unfollow_event' do
    context 'when current user unfollow an event (deny presence)' do
      it 'should unfollow successfuly' do
        @current_user.account.follow(@event)
        post :unfollow_event, params: { uuid: @event.uuid }
        expect(json['result']).to eq('unfollowing')
        expect(@current_user.account.following?(@event)).to be(false)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when current user unfollow a unfollowed event' do
      it 'should return unfollow' do
        post :unfollow_event, params: { uuid: @event.uuid }
        expect(json['result']).to eq('unfollowing')
        expect(@current_user.account.following?(@event)).to be(false)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
