class WeatherService
  def self.current_forecast(location)
    location = GeocodingFacade.new(location).latitude_longitude
    response = conn.get("data/2.5/onecall") do |request|
      request.params['lat'] = location.latitude
      request.params['lon'] = location.longitude
      request.params['exclude'] =  "minutely"
      request.params['units'] =  "imperial"
    end
    WeatherService.parser(response.body)
  end

  private

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org/') do |request|
      request.params['appid'] = ENV['weather_key']
    end
  end
end
