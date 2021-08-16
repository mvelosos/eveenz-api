class Api::V1::RequestFollowsController < ApplicationController
  before_action :request_follow, only: [:update]

  def update
    @request_follow.update(request_follow_params)
    respond_with_object_or_message_status(@request_follow, ApiUuidSuccessSerializer, root: 'request_follow')
  end

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
