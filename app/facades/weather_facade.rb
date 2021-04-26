class WeatherFacade
  def initialize(location)
    service_call = WeatherService.current_forecast(location)
    @current_weather = service_call[:current]
    @daily_weather = service_call[:daily]
    @hourly_weather = service_call[:hourly]
  end

  def current_weather_attribute
    {
     :datetime => Time.at(@current_weather[:dt]),
     :sunrise => Time.at(@current_weather[:sunrise]),
     :sunset => Time.at(@current_weather[:sunset]),
     :temperature => @current_weather[:temp],
     :feels_like => @current_weather[:feels_like],
     :humidity => @current_weather[:humidity],
     :uvi => @current_weather[:uvi],
     :visibility => @current_weather[:visibility],
     :conditions => @current_weather[:weather].first[:description],
     :icon => @current_weather[:weather].first[:icon]
    }
  end

  def current_weather_salaries
    {
     :temperature => "#{@current_weather[:temp]} F",
     :summary => @current_weather[:weather].first[:description],
    }
  end

  def daily_weather_attribute
    @daily_weather[0..4].map do |day|
      {
        :date => Time.at(day[:dt]),
        :sunrise => Time.at(day[:sunrise]),
        :sunset => Time.at(day[:sunset]),
        :max_temp => day[:temp][:max],
        :min_temp => day[:temp][:min],
        :icon => day[:weather].first[:icon],
        :conditions => day[:weather].first[:description]
        }
    end
  end

  def hourly_weather_attribute
    @hourly_weather[0..7].map do |day|
      {
        :time => Time.at(day[:dt]),
        :temperature => day[:temp],
        :icon => day[:weather].first[:icon],
        :conditions => day[:weather].first[:description]
        }
    end
  end

  def poro_creation
    Forecast.new(current_weather_attribute, daily_weather_attribute, hourly_weather_attribute)
  end
end
