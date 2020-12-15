module Authenticators
  extend ActiveSupport::Concern

  def authenticate_by_token
    token = request.headers['Authorization']
    begin
      @decoded_token = JsonWebToken.decode(token)
      @current_user = User.find(@decoded_token[:user_id])
      render json: { errors: Settings.USER_IS_NOT_ACTIVE }, status: :unauthorized unless @current_user.active
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
