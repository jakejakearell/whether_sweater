class GeocodedObject
  attr_reader :latitude,
              :longitude

  def initialize(data)
    @latitude = data[:latitude]
    @longitude = data[:longitude]
  end
end
