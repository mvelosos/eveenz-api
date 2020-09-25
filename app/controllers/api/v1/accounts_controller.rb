class Api::V1::AccountsController < Api::V1::ApiController
  before_action :set_account

  # GET /accounts
  def index
    render json: @account, status: :ok
  end

  # PATCH /accounts
  def update
    if @account.update(account_params)
      render json: '', status: :no_content
    else
      render json: { error: @account.errors.full_messages }, status: :not_acceptable
    end
  end

  # GET /accounts/following
  def following
    render json: @account.following_by_type('Account'), status: :ok
  end

  # GET /accounts/following
  def followers
    render json: @account.followers_by_type('Account'), status: :ok
  end

  private

  def account_params
    params.require(:account).permit(
      :name,
      :bio,
      :latitude,
      :longitude,
      localization_attributes: localization_attr,
      address_attributes: address_attr
    ).to_unsafe_h.to_snake_keys
  end

  def localization_attr
    %i[latitude longitude]
  end

  def address_attr
    %i[street number complement neighborhood zip_code city state country]
  end

  def set_account
    @account = current_user.account
  end
end
