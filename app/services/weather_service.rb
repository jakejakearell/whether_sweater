class WeatherService < ApplicationService
  def self.current_forecast(location)
    location = GeocodingFacade.new(location).check_service_call_status
    response = conn.get("data/2.5/onecall") do |request|
      request.params['lat'] = location.latitude
      request.params['lon'] = location.longitude
      request.params['exclude'] =  "minutely"
      request.params['units'] =  "imperial"
    end
    WeatherService.parser(response.body)
  end

  def self.hourly(location)
    response = conn.get("data/2.5/onecall") do |request|
      request.params['lat'] = location[:latitude]
      request.params['lon'] = location[:longitude]
      request.params['exclude'] =  "minutely,daily,alerts"
      request.params['units'] =  "imperial"
    end
    WeatherService.parser(response.body)
  end

  private

  def self.conn
    Faraday.new('https://api.openweathermap.org/') do |request|
      request.params['appid'] = ENV['weather_key']
    end
  end
end
