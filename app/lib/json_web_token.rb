class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  EXPIRATION_TIME = 720
  ENABLE_EXP_TIME = false

  def self.encode(payload)
    payload[:exp] = EXPIRATION_TIME.hours.to_i if ENABLE_EXP_TIME
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
