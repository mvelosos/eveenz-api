class Api::V1::AccountsController < Api::V1::ApiController
  before_action :account, only: %i[show followers following]

  # GET /accounts/:username
  def show
    render json: @account, current_user: current_user, status: :ok
  end

  # GET /accounts/:username/followers
  def followers
    followers = @account.followers_by_type('Account')
    followers = followers.joins(:user).where('users.username ILIKE ?', "%#{params[:query]}%") if params[:query].present?
    followers = followers.with_attached_avatar.includes(:user)

    render json: followers, each_serializer: AccountFollowSerializer, status: :ok
  end

  # GET /accounts/:username/following
  def following
    following = @account.following_by_type('Account')
    following = following.joins(:user).where('users.username ILIKE ?', "%#{params[:query]}%") if params[:query].present?
    following = following.with_attached_avatar.includes(:user)

    render json: following, each_serializer: AccountFollowSerializer, status: :ok
  end

  private

  def account
    @account = User.find_by_username!(params[:username]).account
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "User #{params[:username]} not found" }, status: :not_found
  end
end
