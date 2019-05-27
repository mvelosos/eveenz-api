class JsonWebToken

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  EXPIRATION_TIME = Settings.JWT_EXPIRATION_TIME

  def self.encode(payload)
    payload[:exp] = EXPIRATION_TIME.hours.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

end
