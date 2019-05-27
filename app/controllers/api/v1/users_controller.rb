module Api
  module V1
    class UsersController < ApiController
      before_action :authenticate_by_token, except: :create
      before_action :get_user, except: %i[create index]

      # GET /users/{username}
      def show
        render json: @user, status: :ok
      end

      # POST /users
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /users/{username}
      def update
        unless @user.update(user_params)
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

        def get_user
          @user = User.find_by_username!(params[:username])
          rescue ActiveRecord::RecordNotFound
            render json: { errors: 'User not found' }, status: :not_found
        end

        def user_params
          params.require(:user).permit(:username, :email, :password)
        end

    end
  end
end
