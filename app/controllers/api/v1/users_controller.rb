class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[create username_available]

  # POST /users
  def create
    @user = Api::V1::Users::NewUserService.call(user_params)
    if @user.save
      auth_user = Api::V1::Auth::AuthService.call(@user)
      render json: auth_user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/username_available?username=""
  def username_available
    user = User.find_by_username(params[:username])

    if user.present? || params[:username].length > 25 || !params[:username].match(/\A[a-zA-Z0-9_.]+\Z/)
      render json: { available: false }, status: :ok
    else
      render json: { available: true }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password
    ).to_unsafe_h.to_snake_keys
  end
end
