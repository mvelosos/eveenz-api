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
    
    end 
  end
end
