class Api::V1::FacebookLoginService
  def initialize(access_token)
    @access_token = access_token
  end

  def login
    fb_user = Facebook.info(@access_token)
    find_or_create_fb_user(fb_user)
  end

  private

  def find_or_create_fb_user(fb_user)
    @user = User.find_or_initialize_by(email: fb_user['email']) do |user|
      user.username = generate_username_from_email
      user.email = fb_user['email']
      user.password = SecureRandom.hex(16)
      user.uid = fb_user['id']
      user.provider = Settings.Providers.FACEBOOK
    end

    if @user.new_record?
      @user.account.update(name: fb_user['name'])
      @user.account.avatar.attach(io: fb_avatar(fb_user), filename: 'avatar')
    end

    @user.update(provider: Settings.Providers.FACEBOOK) if user.provider != Settings.Providers.FACEBOOK
    @user.save!

    @user
  end

  def generate_username_from_email(email)
    "#{email.split('@')[0]}#{rand(9999)}"
  end

  def fb_avatar(fb_user)
    URI.open("https://graph.facebook.com/#{fb_user['id']}/picture?height=500&width=500")
  end
end
