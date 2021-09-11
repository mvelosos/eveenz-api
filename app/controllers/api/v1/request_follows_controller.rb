class Api::V1::RequestFollowsController < ApplicationController
  before_action :request_follow, only: %i[update destroy]

  def update
    if @request_follow.update(request_follow_params)
      render json: { success: true }, status: :accepted
    else
      render json: { success: false }, status: :not_accepted
    end
  end

  def destroy
    if @request_follow.destroy!
      render json: { success: true }, status: :accepted
    else
      render json: { success: false }, status: :not_accepted
    end
  end

  private

  def request_follow
    @request_follow = RequestFollow.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Request Follow #{params[:uuid]} not found" }, status: :not_found
  end

  def request_follow_params
    params.require(:requestFollow).permit(
      :accepted
    ).to_unsafe_h.to_snake_keys
  end
end
