module Authenticators
  extend ActiveSupport::Concern

  def authenticate_by_token
    token = request.headers['Authorization']
    begin
      @decoded_token = JsonWebToken.decode(token)
      @current_user = User.find_by_uuid(@decoded_token[:user_uuid])
      render json: { errors: 'Usuário não autorizado!' }, status: :unauthorized unless @current_user&.active
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
