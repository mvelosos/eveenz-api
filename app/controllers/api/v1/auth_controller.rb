class Api::V1::AuthController < Api::V1::ApiController
  before_action :authenticate_by_token, except: %i[login facebook]

  # POST /auth/login
  def login
    @user = find_by_username_or_email
    if @user&.authenticate(login_params[:password]) && @user&.active
      token = generate_jwt_token(@user)
      time = jwt_expiration_time
      render json: { token: token,
                     type: 'Bearer',
                     exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.username,
                     provider: @user.provider }, status: :ok
    else
      render json: { error: Settings.Exceptions.UNAUTHORIZED }, status: :bad_request
    end
  end

  # POST /auth/facebook
  def facebook
    user = AuthenticationService.new(fb_params[:access_token]).facebook_login
    if user&.active
      token = generate_jwt_token(user)
      time = jwt_expiration_time
      render json: { token: token,
                     type: 'Bearer',
                     exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: user.username,
                     provider: user.provider }, status: :ok
    else
      render json: { error: Settings.Exceptions.UNAUTHORIZED }, status: :bad_request
    end
  rescue Koala::Facebook::APIError => e
    render json: { errors: e.message }, status: :bad_request
  end

  private

  def generate_jwt_token(user)
    @token = JsonWebToken.encode(user_id: user.id)
  end

  def jwt_expiration_time
    Time.now + Settings.Jwt.JWT_EXPIRATION_TIME.hours.to_i
  end

  def find_by_username_or_email
    @user = User.find_by_username(login_params[:login]) || User.find_by_email(login_params[:login])
  end

  def login_params
    params.require(:user).permit(:login, :password)
  end

  def fb_params
    params.permit(:access_token)
  end
end
