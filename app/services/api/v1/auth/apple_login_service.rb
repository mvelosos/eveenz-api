class Api::V1::Auth::AppleLoginService
  def self.call(params)
    obj = new(params)
    obj.login
  end

  def initialize(params)
    @user_id = params[:user_id]
    @jwt = params[:jwt]
    @user = nil
  end

  def login
    apl_user = AppleAuth::UserIdentity.new(@user_id, @jwt).validate!
    find_or_create_apl_user(apl_user)
  end

  private

  def find_or_create_apl_user(apl_user)
    @user = User.find_by_email(apl_user[:email]) || User.find_by_uid(@user_id)

    return nil if @user.present? && @user.provider != User::APPLE_PROVIDER

    unless @user.present?
      user_params = {
        username: generate_username_from_email(apl_user[:email]),
        email: apl_user[:email],
        password: SecureRandom.hex(16)
      }
      @user = Api::V1::Users::NewUserService.call(user_params)
      @user.uid = @user_id
      @user.provider = User::APPLE_PROVIDER
    end

    if @user.new_record?
      @user.account.set_default_avatar
    end

    @user.save!

    @user
  end

  def generate_username_from_email(email)
    "#{email.split('@')[0]}#{rand(9999)}"
  end
end
