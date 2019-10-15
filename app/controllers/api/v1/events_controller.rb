module Api
  module V1
    class Api::V1::EventsController < ApiController

      # TODO: CONTINUAR O DESENVOLVIMENTO DESSE METODO
      # TODO: Adicionar Haversine
      # GET /events
      def index
        @events = Event.all
        render json: @events, status: :ok
      end

      # POST /events
      def create
        @event = current_user.account.events.build(event_params)
        p @event
        p @event.address
        p @event.localization
        # @event.save
      end

      # GET /events/mine
      def mine
        @events = Event.where(account: current_user.account)
        render json: @events, status: :ok
      end

      # GET /events/confirmed
      def confirmed
        @events = Event.joins('INNER JOIN follows ON events.id = follows.followable_id')
                       .where('follows.followable_type = ?', Event)
                       .where('follows.follower_type = ?', Account)
                       .where('follows.follower_id = ?', current_user.account)
        render json: @events, status: :ok
      end

      private
        def event_params
          params.require(:event).permit(:name, :description, :date, :time,  images: [:uri, :type, :name], :address_attributes => address_attr, :localization_attributes => localization_attr)
        end

        def address_attr
          [:number, :street ,:neighborhood ,:city ,:state ,:country ,:zip_code]
        end

        def localization_attr
          [:latitude, :longitude]
        end

        def stores_event_images()
          decoded_image = Base64.decode64(event_params['images'][0]['uri'])
          a = Account.first
          a.avatar.attach(io: StringIO.new(decoded_image), filename: event_params['images'][0]['name'])
        end
    
    end 
  end
end
