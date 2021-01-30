require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  before do
    @user = FactoryBot.create(:user, username: 'foobar', email: 'foobar@eveenz.com', password: 'foo123')
  end

  describe 'POST #login' do
    context 'when has valid credentials' do
      it 'with username, should return auth user' do
        post :login, params: { user: { login: 'foobar', password: 'foo123' } }
        expect(json['token']).to_not be_nil
        expect(json['username']).to eq('foobar')
        expect(response).to  have_http_status(:ok)
      end

      it 'using e-mail, should return auth user' do
        post :login, params: { user: { login: 'foobar@eveenz.com', password: 'foo123' } }
        expect(json['token']).to_not be_nil
        expect(json['username']).to eq('foobar')
        expect(response).to  have_http_status(:ok)
      end
    end

    context 'when has invalid credentials' do
      it 'with username, should return error' do
        post :login, params: { user: { login: 'foo', password: 'foo123' } }
        expect(json['error']).to match(/Ops, login ou senha inválido\(s\)!/)
        expect(response).to  have_http_status(:bad_request)
      end

      it 'using e-mail, should return error' do
        post :login, params: { user: { login: 'foo@eveenz.com', password: 'foo123' } }
        expect(json['error']).to match(/Ops, login ou senha inválido\(s\)!/)
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when user is not active' do
      it 'with username, should return error' do
        @user.update(active: false)
        post :login, params: { user: { login: 'foobar', password: 'foo123' } }
        expect(json['error']).to match(/Ops, login ou senha inválido\(s\)!/)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST #facebook' do
    context 'with valid token' do
      it 'should return auth user' do
        skip 'PENDING'
        post :facebook, params: { facebook: { fbAccessToken: 'foo@eveenz.com' } }
      end
    end

    context 'with invalid token' do
      it 'should return error' do
        post :facebook, params: { facebook: { fbAccessToken: '123456' } }
        expect(json['errors']).to_not be_nil
      end
    end
  end
end
