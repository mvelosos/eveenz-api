require 'rails_helper'

RSpec.describe Api::V1::RequestFollowsController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user).reload
    @account = FactoryBot.create(:user).account
    @request_follow = FactoryBot.create(:request_follow, requested_by_id: @current_user.account.id, account: @account).reload

    @request_follow_params = {
      uuid: @request_follow.uuid,
      requestFollow: {
        accepted: true
      }
    }

    authenticate_user_for_api(@current_user)
  end

  context 'PUT #update' do
    context 'with valid params' do
      it 'when accepted is true should return success = true' do
        put :update, params: @request_follow_params
        expect(json['success']).to eq(true)
        expect(response).to have_http_status(:accepted)
      end

      it 'when accepted is false should return success = true' do
        put :update, params: @request_follow_params.merge(requestFollow: { accepted: false })
        expect(json['success']).to eq(true)
        expect(response).to have_http_status(:accepted)
      end
    end

    # context 'with invalid params' do
    #   it 'return success = false' do

    #     binding.pry

    #     put :update, params: @request_follow_params.merge(requestFollow: { accepted: 'foobar' })
    #     expect(json['success']).to eq(false)
    #     expect(response).to have_http_status(:not_accepted)
    #   end
    # end
  end
end
