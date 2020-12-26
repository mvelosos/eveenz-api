class Api::V1::AccountsController < Api::V1::ApiController
  before_action :account, only: [:show]

  # GET /accounts/:username
  def show
    render json: @account, status: :ok
  end

  private

  def account
    @account = Account.find_by_username!(params[:username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User #{params[:username]} not found" }, status: :not_found
  end
end
