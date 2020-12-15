class Api::V1::AuthController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[login facebook]
  before_action :find_by_username_or_email, only: %i[login]

  # POST /auth/login
  def login
    if @user&.authenticate(login_params[:password]) && @user&.active
      auth_user = Api::V1::Auth::AuthService.call(@user)
      render json: auth_user, status: :ok
    else
      render json: { error: Settings.Exceptions.UNAUTHORIZED }, status: :bad_request
    end
  end

  # POST /auth/facebook
  def facebook
    user = Api::V1::Auth::FacebookLoginService.new(facebook_params[:access_token]).login
    if user&.active
      auth_user = Api::V1::Auth::AuthService.call(user)
      render json: auth_user, status: :ok
    else
      render json: { error: Settings.Exceptions.UNAUTHORIZED }, status: :bad_request
    end
  rescue Koala::Facebook::APIError => e
    render json: { errors: e.message }, status: :bad_request
  end

  private

  def find_by_username_or_email
    @user = User.find_by_username!(login_params[:login]) || User.find_by_email!(login_params[:login])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Ops, login ou senha inválido(s)!' }, status: :bad_request
  end

  def login_params
    params.require(:user).permit(
      :login,
      :password
    ).to_unsafe_h
  end

  def facebook_params
    params.require(:facebook).permit(
      :accessToken
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end
end
