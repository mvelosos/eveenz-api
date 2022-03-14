class Api::V1::FollowsController < Api::V1::ApiController
  before_action :set_follow_account, only: %i[follow_account unfollow_account]
  # before_action :set_follow_event, only: %i[follow_event unfollow_event]

  # POST /me/follows/accounts/:uuid
  def follow_account
    if @follow_account.account_setting.private? && !current_user.account.following?(@follow_account)
      RequestFollow.create!(requested_by: current_user.account, account: @follow_account)
      return render json: { sucess: true, result: 'follow requested' }, status: :created
    end

    current_user.account.follow(@follow_account)
    render json: { sucess: true, result: 'following' }, status: :created
  end

  # DELETE /me/follows/accounts/:uuid
  def unfollow_account
    current_user.account.stop_following(@follow_account)
    render json: { sucess: true, result: 'unfollowing' }, status: :ok
  end

  # POST /me/follows/events/:uuid
  # def follow_event
  #   current_user.account.follow(@follow_event)
  #   render json: { sucess: true, result: 'following' }, status: :created
  # end

  # DELETE /me/follows/events/:uuid
  # def unfollow_event
  #   current_user.account.stop_following(@follow_event)
  #   render json: { sucess: true, result: 'unfollowing' }, status: :ok
  # end

  private

  def set_follow_account
    @follow_account = Account.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  # def set_follow_event
  #   @follow_event = Event.find_by_uuid!(params[:uuid])
  # rescue ActiveRecord::RecordNotFound => e
  #   render json: { errors: e.message }, status: :not_found
  # end
end
