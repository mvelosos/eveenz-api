class Api::V1::AccountsController < Api::V1::ApiController
  before_action :account, only: %i[show followers following]

  # GET /accounts/:username
  def show
    render json: @account, status: :ok
  end

  # GET /accounts/:uuid/followers
  def followers
    render json: @account.followers_by_type('Account'), status: :ok
  end

  # GET /accounts/:uuid/following
  def following
    render json: @account.following_by_type('Account'), status: :ok
  end

  private

  def account
    @account = Account.find_by_username!(params[:username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User #{params[:username]} not found" }, status: :not_found
  end
end
