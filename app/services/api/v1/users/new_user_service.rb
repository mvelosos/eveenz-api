class Api::V1::Users::NewUserService
  def self.call(user_params)
    obj = new(user_params)
    obj.run
  end

  def initialize(user_params)
    @user_params = user_params
  end

  def run
    user = User.new(@user_params)
    user.provider = User::API_PROVIDER
    user.build_account
    user.account.build_account_setting
    user.account.build_address
    user.account.build_localization
    user.account.name = @user_params['username']

    user
  end
end
