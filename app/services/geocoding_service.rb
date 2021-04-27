class GeocodingService
  def self.address_cordinates(location)
    response = conn.get("geocoding/v1/address?location=#{location}")
    GeocodingService.parser(response.body)
  end

  def self.road_trip(destination)
    response = conn.get("directions/v2/route") do |request|
      request.params['from'] = destination["origin"]
      request.params['to'] = destination["destination"]
    end
    GeocodingService.parser(response.body)
  end

  private

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/') do |request|
      request.params['key'] = ENV['geocode_key']
    end
  end
end
