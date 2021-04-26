class GeocodingFacade
  def initialize(location)
    @data = GeocodingService.address_cordinates(location)
  end

  def parse_service_call
    {
      latitude: @data[:results].first[:locations].first[:latLng][:lat],
      longitude: @data[:results].first[:locations].first[:latLng][:lng]
      }
  end

  def latitude_longitude
    GeocodedObject.new(parse_service_call)
  end
end
