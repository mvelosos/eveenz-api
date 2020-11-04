class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_by_token, except: [:create]
  before_action :user, only: [:show]

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save && @user.active
      auth_user = Api::V1::AuthService.call(@user)
      render json: auth_user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user
    @user = User.find_by_username!(params[:username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    ).to_unsafe_h.to_snake_keys
  end
end
