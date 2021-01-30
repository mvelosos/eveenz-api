require 'rails_helper'

RSpec.describe Api::V1::PasswordsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)

    @forgot_params = {
      password: {
        login: @user.username
      }
    }

    @recover_password_params = {
      passwordRecovery: {
        code: '',
        token: '',
        password: '',
        passwordConfirmation: ''
      }
    }
  end

  describe 'POST #forgot' do
    context 'when user provider is not equal to api' do
      it 'returns message' do
        @user.update(provider: 'facebook')
        post :forgot, params: @forgot_params
        expect(json['message']).to_not be_nil
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user requests recover with valid params' do
      it 'returns message' do
        post :forgot, params: @forgot_params
        expect(json['valid']).to be(true)
        expect(json['email']).to eq(@user.email)
        expect(response).to have_http_status(:ok)
        expect(UserRecoveryPasswordJob).to have_been_enqueued.on_queue('default')
      end
    end

    context 'when user requests recover with invalid params' do
      it 'returns not found with username' do
        post :forgot, params: @forgot_params.deep_merge(password: { login: 'foo' })
        expect(json['error']).to_not be_nil
        expect(json['error']).to match(/E-mail ou nome de usuário informado não existe!/)
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns not found with e-mail' do
        post :forgot, params: @forgot_params.deep_merge(password: { login: 'foo@eveenz.com' })
        expect(json['error']).to_not be_nil
        expect(json['error']).to match(/E-mail ou nome de usuário informado não existe!/)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST #verify_code' do
    before do
      UserRecoveryPasswordJob.perform_now(@user.id)
    end

    context 'when code is valid' do
      it 'should be valid and return a token' do
        params = @recover_password_params.deep_merge(passwordRecovery: { code: @user.password_recovery.code })
        post :verify_code, params: params
        expect(json['valid']).to be(true)
        expect(json['token']).to_not be_nil
        expect(json['token']).to eq(@user.password_recovery.reload.token)
        expect(response).to have_http_status(:accepted)
      end
    end

    context 'when code is not valid' do
      it 'should return error message and bad request' do
        params = @recover_password_params.deep_merge(passwordRecovery: { code: 'foo' })
        post :verify_code, params: params
        expect(json['error']).to match(/O código de verificação informado não é válido!/)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST #recover_password' do
    before do
      UserRecoveryPasswordJob.perform_now(@user.id)
      @password_recovery = @user.password_recovery
      @password_recovery.update(token: SecureRandom.hex(16))
    end

    context 'when params is valid' do
      it 'should successfuly recover password' do
        params = @recover_password_params.deep_merge(passwordRecovery: {
                                                       token: @password_recovery.token,
                                                       password: 'foo123',
                                                       passwordConfirmation: 'foo123'
                                                     })
        post :recover_password, params: params
        expect(@user.reload.password_recovery.nil?).to be(true)
        expect(json['valid']).to be(true)
        expect(json['message']).to match(/Senha alterada com sucesso!/)
        expect(response).to have_http_status(:accepted)
      end
    end

    context 'when params is not valid' do
      it 'with unmatched password' do
        params = @recover_password_params.deep_merge(passwordRecovery: {
                                                       token: @password_recovery.token,
                                                       password: 'foo123',
                                                       passwordConfirmation: 'foo'
                                                     })
        post :recover_password, params: params
        expect(json['error']).to match(/As a senhas não coincidem!/)
        expect(response).to have_http_status(:bad_request)
      end

      it 'with invalid token' do
        params = @recover_password_params.deep_merge(passwordRecovery: {
                                                       token: 'foobar',
                                                       password: 'foo123',
                                                       passwordConfirmation: 'foo123'
                                                     })
        post :recover_password, params: params
        expect(json['error']).to match(/Erro ao recuperar senha, tente novamente mais tarde/)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
