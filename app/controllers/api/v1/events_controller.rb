module Api
  module V1
    class Api::V1::EventsController < Api::V1::ApiController
      # GET /events
      def index
        account   = current_user.account
        latitude  = account.localization.latitude
        longitude = account.localization.longitude

        @events = Event.find_near_by(latitude, longitude, account.account_setting.distance_radius, account.account_setting.unit)
                       .order(created_at: :desc)

        render json: @events, each_serializer: EventSerializer, current_user: current_user, status: :ok
      end

      # POST /events
      def create
        @event = current_user.account.events.build(event_params)
        if @event.save
          stores_event_images
          render json: @event, serializer: EventSerializer, current_user: current_user, status: :created
        else
          render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /events/mine
      def mine
        @events = Event.where(account: current_user.account)
        render json: @events, each_serializer: EventSerializer, current_user: current_user, status: :ok
      end

      # GET /events/confirmed
      def confirmed
        @events = Event.joins('INNER JOIN follows ON events.id = follows.followable_id')
                       .where('follows.followable_type = ?', Event)
                       .where('follows.follower_type = ?', Account)
                       .where('follows.follower_id = ?', current_user.account)
        render json: @events, each_serializer: EventSerializer, current_user: current_user, status: :ok
      end

      private

      def event_params
        params.require(:event).permit(:name, :description, :date, :time, address_attributes: address_attr, localization_attributes: localization_attr)
      end

      def event_images_params
        params.require(:event).permit(images: %i[uri name type])
      end

      def address_attr
        %i[number street neighborhood city state country zip_code]
      end

      def localization_attr
        %i[latitude longitude]
      end

      def stores_event_images
        images = event_images_params[:images]
        images.each do |img|
          decoded_img = Base64.decode64(img[:uri])
          @event.images.attach(io: StringIO.new(decoded_img), filename: img[:name], content_type: img[:type])
        end
      end
    end
  end
end
