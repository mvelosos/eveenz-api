class Api::V1::EventsController < Api::V1::ApiController
  before_action :event, only: %i[update]

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

  # PUT/PATCH /events/:uuid
  def update
    return render json: { error: 'unauthorized' }, status: :unauthorized if @event.account_id != current_user.account.id

    @event.update(event_params)
    render json: @event, serializer: EventSerializer, account: current_user.account, status: :ok
  end

  private

  def event
    @event = Event.find_by_uuid!(params[:uuid])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event #{params[:uuid]} not found" }, status: :not_found
  end

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :startDate,
      :endDate,
      :startTime,
      :endTime,
      :undefinedEnd,
      :externalUrl,
      :minimumAge,
      :privacy,
      addressAttributes: %i[street number complement neighborhood city state country zipCode],
      localizationAttributes: %i[latitude longitude],
      eventCategoriesAttributes: %i[id categoryId _destroy],
      images: %i[data filename]
    ).to_unsafe_h.to_snake_keys
  end
end
