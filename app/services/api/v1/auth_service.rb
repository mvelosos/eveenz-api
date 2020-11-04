class Api::V1::AuthService
  def initialize(access_token)
    @access_token = access_token
  end

  def facebook_login
    fb_user = Facebook.info(@access_token)
    find_or_create_fb_user(fb_user)
  end

  private

  def find_or_create_fb_user(fb_user)
    user = User.find_by_email(fb_user['email'])
    if user && user.provider.nil?
      user.update(uid: fb_user['id'], provider: Settings.Providers.FACEBOOK)
    elsif user
      user
    else
      username = generate_username_from_email(fb_user['email'])
      user = User.create(username: username,
                         email: fb_user['email'],
                         password: SecureRandom.hex(16),
                         uid: fb_user['id'],
                         provider: Settings.Providers.FACEBOOK)
      user.account.update(name: fb_user['name'])

      file = URI.open("https://graph.facebook.com/#{fb_user['id']}/picture?height=500&width=500")
      user.account.avatar.attach(io: file, filename: 'avatar')
    end
    user
  end

  def generate_username_from_email(email)
    "#{email.split('@')[0]}#{rand(9999)}"
  end
end
