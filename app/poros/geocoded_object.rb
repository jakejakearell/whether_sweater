class GeocodedObject
  attr_reader :latitude,
              :longitude

  def initialize(data)
    @latitude = data[:results].first[:locations].first[:latLng][:lat]
    @longitude = data[:results].first[:locations].first[:latLng][:lng]
  end

end
