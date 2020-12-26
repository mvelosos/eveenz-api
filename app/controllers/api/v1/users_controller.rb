class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate_by_token, except: [:create]

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      auth_user = Api::V1::Auth::AuthService.call(@user)
      render json: auth_user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      accountAttributes: [:username]
    ).to_unsafe_h.to_snake_keys
  end
end
