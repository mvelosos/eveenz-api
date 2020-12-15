class Api::V1::MeController < ApplicationController
  before_action :me

  def show
    render json: @account, status: :ok
  end

  # GET /me/following
  def following
    render json: @account.following_by_type('Account'), status: :ok
  end

  # GET /me/followers
  def followers
    render json: @account.followers_by_type('Account'), status: :ok
  end

  # GET /me/events/mine
  def mine
    @events = Event.where(account: @account)
    render json: @events, each_serializer: EventSerializer, account: @account, status: :ok
  end

  # GET /me/events/confirmed
  def confirmed
    @events = Event.joins('INNER JOIN follows ON events.id = follows.followable_id')
                   .where('follows.followable_type = ?', Event)
                   .where('follows.follower_type = ?', Account)
                   .where('follows.follower_id = ?', @account)
    render json: @events, each_serializer: EventSerializer, account: @account, status: :ok
  end

  private

  def me
    @account = current_user.account
  end
end
