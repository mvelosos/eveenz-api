module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authenticate_by_token, except: [:login]

      # POST /auth/login
      def login
        @user = find_by_username_or_email
        if @user && @user.authenticate(login_params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + Settings.JWT_EXPIRATION_TIME.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

        def login_params
          params.require(:user).permit(:login, :password)
        end

        def find_by_username_or_email
          @user = User.find_by_username(login_params[:login]) || User.find_by_email(login_params[:login])
        end

    end
  end
end