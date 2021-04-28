class PhotoService < ApplicationService

  def self.photo_location_lat_lon_search(location)
    location = GeocodingFacade.new(location).latitude_longitude
    response = conn.get("/services/rest") do |request|
      request.params['method'] =  "flickr.photos.search"
      request.params['lat'] = location.latitude
      request.params['lon'] = location.longitude
      request.params['accuracy'] = 11
      request.params['geo_context'] =  2
    end
    PhotoService.parser(response.body)
  end

  def self.photo_lookup(id)
    response = conn.get("/services/rest") do |request|
      request.params['method'] =  "flickr.photos.getInfo"
      request.params['photo_id'] =  id
    end
    PhotoService.parser(response.body)
  end

  private

  def self.conn
    Faraday.new('https://api.flickr.com') do |request|
      request.params['api_key'] = ENV['photo_key']
      request.params['format'] = 'json'
      request.params['nojsoncallback'] = 1
    end
  end
end
