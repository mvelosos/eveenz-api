class Api::V1::EventsController < ApplicationController

  # TODO: CONTINUAR O DESENVOLVIMENTO DESSE METODO
  # GET /events
  def index
    @events = Event.all
    render json: @events, status: :ok
  end

end
