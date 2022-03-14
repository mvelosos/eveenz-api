class Api::V1::Home::CardsContructorService
  include Rails.application.routes.url_helpers

  def self.call(current_user, localization)
    obj = new(current_user, localization)
    obj.run
  end

  def initialize(current_user, localization)
    @current_user = current_user
    @localization = localization
    @unit = @current_user.account.account_setting.unit
    @distance_radius = 20
    @events = nil
  end

  def run
    haversine = MyHaversine.call(@localization[:lat], @localization[:lon], @unit)
    @events = Event.with_attached_images
                   .includes(:address)
                   .includes(:localization)
                   .joins(:localization)
                   .where("#{haversine} <= ?", @distance_radius)
                   .kept

    response_data
  end

  def response_data
    [
      {
        title: 'EM ALTA',
        cardType: 'wide',
        data: query_cards_1
      },
      {
        title: 'PERTO DE MIM',
        cardType: 'square',
        data: query_cards_1
      },
      {
        title: '#TO CONFIRMADO',
        cardType: 'square',
        data: query_cards_1
      }
    ]
  end

  def query_cards_1
    format_result_data(@events)
  end

  def format_result_data(collection)
    return unless collection.class.to_s.include? 'Event'

    collection.collect do |event|
      {
        uuid: event.uuid,
        name: event.name,
        distance: calculate_distance(event.localization.latitude, event.localization.longitude),
        startDate: event.start_date,
        startTime: event.start_time,
        address: {
          street: event.address.street,
          number: event.address.number,
          complement: event.address.complement,
          neighborhood: event.address.neighborhood,
          zipCode: event.address.zip_code,
          city: event.address.city,
          state: event.address.state,
          country: event.address.country
        },
        image: event.images.attached? ? rails_blob_url(event.images.first) : nil
      }
    end
  end

  def calculate_distance(event_latitude, event_longitude)
    distance = Haversine.distance(@localization[:lat].to_f, @localization[:lon].to_f, event_latitude, event_longitude)
    @unit == 'km' ? "#{distance.to_km.ceil(2)}km" : "#{distance.to_mi.ceil(2)}mi"
  end
end
