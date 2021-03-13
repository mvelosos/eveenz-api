require 'rails_helper'

RSpec.describe Api::V1::RequestCategoriesController, type: :controller do
  before do
    @current_user = FactoryBot.create(:user)

    @params = {
      requestCategory: {
        name: SecureRandom.hex(16)
      }
    }

    authenticate_user_for_api(@current_user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'should sucessfuly create a request_category' do
        post :create, params: @params
        expect(json['requestCategory']['id']).to_not be_nil
        expect(@current_user.account.requested_categories).to_not be_empty
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid params' do
      it 'should return error' do
        post :create, params: @params.deep_merge(requestCategory: { name: nil })
        expect(json['error']).to_not be_nil
        expect(response).to have_http_status(406)
      end
    end
  end
end
