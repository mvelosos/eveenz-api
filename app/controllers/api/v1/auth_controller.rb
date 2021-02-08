class Api::V1::AuthController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[login facebook google]
  before_action :find_by_username_or_email, only: %i[login]

  # POST /auth/login
  def login
    if @user&.authenticate(login_params[:password]) && @user&.active && @user.provider == User::API_PROVIDER
      auth_user = Api::V1::Auth::AuthService.call(@user)
      render json: auth_user, status: :ok
    else
      render json: { error: 'Ops, login ou senha inválido(s)!' }, status: :bad_request
    end
  end

  # POST /auth/facebook
  def facebook
    user = Api::V1::Auth::FacebookLoginService.call(facebook_params[:fb_access_token])
    if user&.active && user.provider == User::FACEBOOK_PROVIDER
      auth_user = Api::V1::Auth::AuthService.call(user)
      render json: auth_user, status: :ok
    else
      render json: { error: 'Ops, não foi possível fazer o login!' }, status: :bad_request
    end
  rescue Koala::Facebook::APIError => e
    render json: { error: e.message }, status: :bad_request
  end

  # POST /auth/google
  # :nocov:
  def google
    user = Api::V1::Auth::GoogleLoginService.call(google_params[:gl_access_token])
    if user&.active && user.provider == User::GOOGLE_PROVIDER
      auth_user = Api::V1::Auth::AuthService.call(user)
      render json: auth_user, status: :ok
    else
      render json: { error: 'Ops, não foi possível fazer o login!' }, status: :bad_request
    end
  end
  # :nocov:


  private

  def find_by_username_or_email
    @user = User.find_by_username(login_params[:login]) || User.find_by_email!(login_params[:login])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ops, login ou senha inválido(s)!' }, status: :bad_request
  end

  def login_params
    params.require(:user).permit(
      :login,
      :password
    ).to_unsafe_h
  end

  def facebook_params
    params.require(:facebook).permit(
      :fbAccessToken
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end

  # :nocov:
  def google_params
    params.require(:google).permit(
      :glAccessToken
    ).to_unsafe_h.to_snake_keys.symbolize_keys
  end
  # :nocov:
end
