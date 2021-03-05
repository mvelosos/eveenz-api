class Api::V1::EventsController < Api::V1::ApiController
  # GET /events
  def index
    account = current_user.account
    @events = Api::V1::Events::NearEventsService.call(account)

    render json: @events, each_serializer: EventSerializer, account: current_user.account, status: :ok
  end

  # POST /events
  def create
    @event = current_user.account.events.build(event_params)
    if @event.save
      render json: @event.reload, serializer: EventSerializer, account: current_user.account, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :startDate,
      :endDate,
      :startTime,
      :endTime,
      :undefinedEnd,
      :privacy,
      addressAttributes: %i[street number neighborhood city state country zipCode],
      localizationAttributes: %i[latitude longitude],
      images: %i[data filename]
    ).to_unsafe_h.to_snake_keys
  end
end
