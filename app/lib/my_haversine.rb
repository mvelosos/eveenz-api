class MyHaversine
  def self.call(latitude, longitude, unit)
    obj = new(latitude, longitude, unit)
    obj.run
  end

  def initialize(latitude, longitude, unit)
    @latitude  = latitude
    @longitude = longitude
    @unit      = unit
  end

  def run
    unit_value = @unit == 'km' ? 6371 : 3959

    "(#{unit_value} * acos(cos(radians(#{@latitude}))
    * cos(radians(localizations.latitude))
    * cos(radians(localizations.longitude)
    - radians(#{@longitude}))
    + sin(radians(#{@latitude}))
    * sin(radians(localizations.latitude))))"
  end
end
