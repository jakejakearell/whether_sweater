class PhotoService

  def self.photo_location_lat_lon_search(location)
    location = GeocodingFacade.latitude_longitude(location)
    response = conn.get("/services/rest") do |request|
      request.params['method'] =  "flickr.photos.search"
      request.params['lat'] = location.latitude
      request.params['lon'] = location.longitude
      request.params['geo_context'] =  2
    end
    PhotoService.parser(response.body)
  end

  def self.photo_lookup(id="6066076873")
    response = conn.get("/services/rest") do |request|
      request.params['method'] =  "flickr.photos.getInfo"
      request.params['photo_id'] =  id
    end
    PhotoService.parser(response.body)
  end

  private

  def self.parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.flickr.com') do |request|
      request.params['api_key'] = ENV['photo_key']
      request.params['format'] = 'json'
      request.params['nojsoncallback'] = 1
    end
  end
end
