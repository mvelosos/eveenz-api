require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    before do
      @user_params = {
        user: {
          email: Faker::Internet.free_email,
          username: Faker::Internet.username(specifier: 5..24),
          password: Faker::Internet.password
        }
      }
    end

    context 'with valid params' do
      it 'should create a user' do
        post :create, params: @user_params
        expect(response).to have_http_status(:created)
      end

      it 'should create a user and user should have name equals username' do
        post :create, params: @user_params
        created_user = User.find_by_username(@user_params[:user][:username])
        expect(response).to have_http_status(:created)
        expect(created_user.account.name).to eq(@user_params[:user][:username])
      end

      it 'should create a user and user should have associations created' do
        post :create, params: { user: { email: 'foo@bar.com', username: 'foo', password: 'foo123' } }
        expect(response).to have_http_status(:created)
        expect(User.find_by_username('foo').account).to_not be_nil
        expect(User.find_by_username('foo').account.account_setting).to_not be_nil
        expect(User.find_by_username('foo').account.address).to_not be_nil
        expect(User.find_by_username('foo').account.localization).to_not be_nil
      end

      it 'should return auth user' do
        post :create, params: @user_params
        expect(json['username']).to_not be_nil
        expect(json['createdAt']).to_not be_nil
        expect(json['token']).to_not be_nil
        expect(json['tokenType']).to_not be_nil
        expect(json['exp']).to_not be_nil
        expect(json['provider']).to_not be_nil
      end
    end

    context 'with invalid params' do
      it 'should return error when username is nil' do
        post :create, params: @user_params.deep_merge(user: { username: nil })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when username is less than 3 characters' do
        post :create, params: @user_params.deep_merge(user: { username: 'ab' })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when username is bigger than 25 characters' do
        post :create, params: @user_params.deep_merge(user: { username: Faker::Internet.username(specifier: 26) })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when username is bigger has special characters' do
        post :create, params: @user_params.deep_merge(user: { username: 'foo*bar' })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when email is already in use' do
        user = FactoryBot.create(:user)
        post :create, params: @user_params.deep_merge(user: { email: user.email })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when email is not valid' do
        post :create, params: @user_params.deep_merge(user: { email: 'foobar@' })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error when password is less than 6 characters' do
        post :create, params: @user_params.deep_merge(user: { password: '12345' })
        expect(json['errors']).to_not be_empty
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #username_available' do
    context 'with available username' do
      it 'should be available' do
        get :username_available, params: { username: Faker::Internet.username }
        expect(json['available']).to be(true)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with unavailable username' do
      it 'should not be available' do
        user = FactoryBot.create(:user)
        get :username_available, params: { username: user.username }
        expect(json['available']).to be(false)
      end

      it 'should return status ok even if is unavailable' do
        user = FactoryBot.create(:user)
        get :username_available, params: { username: user.username }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
