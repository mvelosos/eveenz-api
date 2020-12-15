class Api::V1::AccountsController < Api::V1::ApiController
  before_action :account

  # PUT/PATCH /accounts
  def update
    if @account.update(account_params)
      render json: '', status: :no_content
    else
      render json: { error: @account.errors.full_messages }, status: :not_acceptable
    end
  end

  private

  def account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :name,
      :bio,
      :popularity,
      localizationAttributes: %i[latitude longitude],
      addressAttributes: %i[street number complement neighborhood zipCode city state country]
    ).to_unsafe_h.to_snake_keys
  end
end
