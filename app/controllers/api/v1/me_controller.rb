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

  private

  def me
    @account = current_user.account
  end
end
