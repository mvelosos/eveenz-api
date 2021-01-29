module Auth
  module SecurityHelpers
    def authenticate_user_for_api(user)
      auth_user = Api::V1::Auth::AuthService.call(user)
      request.headers['Authorization'] = auth_user['token']
    end
  end
end
