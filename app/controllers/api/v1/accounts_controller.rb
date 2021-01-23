class Api::V1::AccountsController < Api::V1::ApiController
  before_action :account, only: %i[show followers following]

  # GET /accounts/:username
  def show
    render json: @account, status: :ok
  end

  # GET /accounts/:username/followers
  def followers
    render json: @account.followers_by_type('Account'), status: :ok
  end

  # GET /accounts/:username/following
  def following
    render json: @account.following_by_type('Account'), status: :ok
  end

  private

  def account
    @account = User.find_by_username!(params[:username]).account
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User #{params[:username]} not found" }, status: :not_found
  end
end
