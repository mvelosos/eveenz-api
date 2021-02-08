class Api::V1::Auth::FacebookLoginService
  def self.call(access_token)
    obj = new(access_token)
    obj.login
  end

  def initialize(access_token)
    @access_token = access_token
  end

  def login
    fb_user = Facebook.info(@access_token)
    find_or_create_fb_user(fb_user)
  end

  private

  def find_or_create_fb_user(fb_user)
    @user = User.find_by_email(fb_user['email'])

    unless @user.present?
      user_params = {
        username: generate_username_from_email(fb_user['email']),
        email: fb_user['email'],
        password: SecureRandom.hex(16)
      }
      @user = Api::V1::Users::NewUserService.call(user_params)
      @user.provider = User::FACEBOOK_PROVIDER
    end

    if @user.new_record?
      @user.account.update(name: fb_user['name'])
      @user.account.avatar.attach(io: fb_avatar(fb_user), filename: 'avatar')
    end

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
