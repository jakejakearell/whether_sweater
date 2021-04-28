class RoadTripFacade
  attr_reader :destination

  def initialize(destination)
    @destination = destination
    @data = GeocodingService.road_trip(destination)
  end

  def destination_location
    {
      :longitude => @data[:route][:boundingBox][:lr][:lng],
      :latitude => @data[:route][:boundingBox][:lr][:lat]
    }
  end

  def route_time
    @data[:route][:formattedTime]
  end

  def forty_eight_hours_of_forecast
    WeatherService.hourly(destination_location)[:hourly]
  end

  def choose_time
    eta = @data[:route][:realTime] + (Time.now).to_i

    forty_eight_hours_of_forecast.min_by do |hour|
      (hour[:dt] - eta).abs
    end
  end

  def assess_road_trip_viability
    if @data[:route][:routeError][:errorCode] == 2
      RoadTrip.new(nil, "impossible", destination)
    elsif @data[:route][:routeError][:errorCode] != -400
      false
    else
      RoadTrip.new(choose_time, route_time, destination )
    end
  end
end
