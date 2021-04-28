class RoadTrip

  attr_reader :start_city,
              :id,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data, route_time, destination={"origin" => "none" , "destination" => "none" })
    @id = "null"
    @start_city = destination["origin"] 
    @end_city = destination["destination"] 
    @travel_time = route_time
    @weather_at_eta = weather_checker(data)
  end

  def weather_checker(data)
    if data
      {:temperature => data[:temp],:conditions => data[:weather].first[:description]}
    else
      {:temperature => "impossible",:conditions => "impossible"}
   end
  end
end
