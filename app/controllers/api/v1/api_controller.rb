module Api
  module V1
    class ApiController < ApplicationController

      attr_accessor :current_user

      def not_found
        render json: { error: 'not_found' }
      end
    
      def authenticate_by_token
        token = request.headers['Authorization']
        token = token.split(' ').last if token
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
  end
end
