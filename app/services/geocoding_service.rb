class GeocodingService
  def self.address_cordinates(location)
    response = conn.get("?location=#{location}")
    GeocodingService.parser(response.body)
  end

  private

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/address') do |request|
      request.params['key'] = ENV['geocode_key']
    end
  end
end
