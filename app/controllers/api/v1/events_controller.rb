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
    
    end 
  end
end
