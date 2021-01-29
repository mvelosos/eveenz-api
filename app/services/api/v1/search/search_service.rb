class Api::V1::Search::SearchService
  include Rails.application.routes.url_helpers

  def self.call(account, params = {})
    obj = new(account, params)
    obj.run
  end

  def initialize(account, params = {})
    @account = account
    @params = params
    @data = []
  end

  def run
    JSON.parse({
      data: query_data
    }.to_json)
  end

  def query_data
    search_accounts
    search_events

    @data
  end

  def search_accounts
    accounts = Account.search(@params[:query], misspellings: { edit_distance: 3 }, page: 1, per_page: 50)
    accounts.each do |account|
      @data << {
        uuid: account.uuid,
        type: 'account',
        username: account.user.username,
        name: account.name,
        avatar_url: rails_blob_url(account.avatar, only_path: true)
      }
    end
  end

  def search_events
    events = Event.search(@params[:query], misspellings: { edit_distance: 3 }, page: 1, per_page: 50)
    events.each do |event|
      @data << {
        uuid: event.uuid,
        type: 'event',
        name: event.name,
        image_url: event.images&.first ? rails_blob_url(event.image.first) : nil,
        distance: current_distance(event)
      }
    end
  end

  def current_distance(event)
    return nil # TODO: Refactor this later
    return nil if @account.localization.latitude.nil?
    return nil if event.localization&.latitude

    unit = @account.account_setting.unit

    distance = Haversine.distance(@account.localization.latitude,
                                  @account.localization.longitude,
                                  event.localization.latitude,
                                  event.localization.longitude)

    unit == 'km' ? "#{distance.to_km.ceil(2)}km" : "#{distance.to_mi.ceil(2)}mi"
  end
end
