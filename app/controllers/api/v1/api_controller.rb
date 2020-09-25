module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_by_token
      before_action :set_raven_context

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

      private

      def set_raven_context
        if current_user
          Raven.user_context(id: current_user.id, username: current_user.username)
        else
          Raven.user_context(message: 'user not authenticated')
        end
        Raven.extra_context(params: params.to_unsafe_h, url: request.url)
      end
    end
  end
end
