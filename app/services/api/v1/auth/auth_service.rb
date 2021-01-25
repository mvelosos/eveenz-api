class Api::V1::Auth::AuthService
  def self.call(user)
    obj = new(user)
    obj.run
  end

  def initialize(user)
    @user = user.reload
  end

  def run
    JSON.parse({
      username: @user.username,
      createdAt: @user.created_at,
      token: generate_jwt_token,
      tokenType: token_type,
      exp: jwt_expiration_time,
      provider: @user.provider
    }.to_json)
  end

  private

  def generate_jwt_token
    JsonWebToken.encode(user_uuid: @user.uuid)
  end

  def token_type
    'Bearer'
  end

  def jwt_expiration_time
    (Time.now + Settings.Jwt.JWT_EXPIRATION_TIME.hours.to_i).strftime('%Y-%m-%d %H:%M')
  end
end
