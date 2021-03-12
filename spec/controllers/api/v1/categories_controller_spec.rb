require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe 'GET #index' do
    before do
      @current_user = FactoryBot.create(:user).reload
      @categories = FactoryBot.create_list(:category, 12)

      authenticate_user_for_api(@current_user)
    end

    context 'with no arguments' do
      it 'should return a list of categories' do
        get :index
        expect(json['categories'].count).to eq(12)
      end
    end
  end
end
