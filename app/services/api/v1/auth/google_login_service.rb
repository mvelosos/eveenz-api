class Api::V1::Auth::GoogleLoginService
  def self.call(access_token)
    obj = new(access_token)
    obj.login
  end

  def initialize(access_token)
    @access_token = access_token
  end

  def login
    gl_user = Google.info(@access_token)
    find_or_create_gl_user(gl_user)
  end

  private

  def find_or_create_gl_user(gl_user)
    @user = User.find_by_email(gl_user['email'])

    return nil if @user.present? && @user.provider != User::GOOGLE_PROVIDER

    unless @user.present?
      user_params = {
        username: generate_username_from_email(gl_user['email']),
        email: gl_user['email'],
        password: SecureRandom.hex(16)
      }
      @user = Api::V1::Users::NewUserService.call(user_params)
      @user.uid = gl_user['id']
      @user.provider = User::GOOGLE_PROVIDER
    end

    if @user.new_record?
      @user.account.update(name: gl_user['name'])
      @user.account.avatar.attach(io: gl_avatar(gl_user), filename: 'avatar')
    end

    @user.save!

    @user
  end

  def generate_username_from_email(email)
    "#{email.split('@')[0]}#{rand(9999)}"
  end

  def gl_avatar(gl_user)
    URI.open(gl_user['picture'])
  end
end
