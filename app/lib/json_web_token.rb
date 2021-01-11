class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  EXPIRATION_TIME = Settings.Jwt.JWT_EXPIRATION_TIME
  ENABLE_EXP_TIME = Settings.Jwt.ENABLE_EXP_TIME

  def self.encode(payload)
    payload[:exp] = EXPIRATION_TIME.hours.to_i if ENABLE_EXP_TIME
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
