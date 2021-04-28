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

  def check_service_call_status
    if @data.nil? || @data[:info][:statuscode] == 400
      GeocodedObject.new({latitude: 90, longitude: 135 })
    else
      latitude_longitude
    end
  end

  def latitude_longitude
    GeocodedObject.new(parse_service_call)
  end
end
