class GeocodingFacade
  def self.latitude_longitude(location)
    data = GeocodingService.address_cordinates(location)
    GeocodedObject.new(data)
  end
end
