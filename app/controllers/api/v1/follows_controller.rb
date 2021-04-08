class Api::V1::FollowsController < Api::V1::ApiController
  before_action :set_follow_account, only: %i[follow_account unfollow_account]
  before_action :set_follow_event, only: %i[follow_event unfollow_event]

  # POST /me/follows/accounts/:uuid
  def follow_account
    current_user.account.follow(@follow_account)
    render json: { result: 'following' }, status: :created
  end

  # DELETE /me/follows/accounts/:uuid
  def unfollow_account
    current_user.account.stop_following(@follow_account)
    render json: { result: 'unfollowing' }, status: :ok
  end

  # POST /me/follows/events/:uuid
  def follow_event
    current_user.account.follow(@follow_event)
    render json: { result: 'following' }, status: :created
  end

  # DELETE /me/follows/events/:uuid
  def unfollow_event
    current_user.account.stop_following(@follow_event)
    render json: { result: 'unfollowing' }, status: :ok
  end

  private

  def set_follow_account
    @follow_account = Account.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  def set_follow_event
    @follow_event = Event.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end
end
