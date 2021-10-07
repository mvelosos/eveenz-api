class Api::V1::EventPresencesController < Api::V1::ApiController
  before_action :event, only: %i[create]
  before_action :event_presence, only: %i[destroy]

  def create
    @event_presence = EventPresence.create(event: @event, account: current_user.account)
    respond_with_object_or_message_status(@event_presence, ApiUuidSuccessSerializer)
  end

  def destroy
    if @event_presence.account.id == current_user.account.id
      @event_presence.destroy
      respond_with_object_or_message_status(@event_presence, ApiUuidSuccessSerializer)
    else
      render json: { success: false }, status: :not_acceptable
    end
  end

  private

  def event_presence
    @event_presence = EventPresence.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event Presence #{params[:uuid]} not found" }, status: :not_found
  end

  def event
    @event = Event.find_by_uuid!(params[:event_uuid])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event #{params[:event_uuid]} not found" }, status: :not_found
  end
end
