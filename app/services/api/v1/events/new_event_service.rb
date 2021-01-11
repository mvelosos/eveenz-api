class Api::V1::Events::NewEventService
  def self.call(account)
    obj = new(account)
    obj.run
  end

  def initialize(account)
    @account         = account
    @latitude        = @account.localization.latitude
    @longitude       = @account.localization.longitude
    @unit            = @account.account_setting.unit
    @distance_radius = @account.account_setting.distance_radius
  end

  def run
    haversine = MyHaversine.call(@latitude, @longitude, @unit)
    Event.joins(:localization).select("events.*, #{haversine} as distance").where("#{haversine} <= ?", @distance_radius)
  end
end
