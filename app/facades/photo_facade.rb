class PhotoFacade

  def initialize(location)
    @location = location
    @service_call = PhotoService.photo_location_lat_lon_search(@location)
  end

  def photo_id
    @service_call[:photos][:photo].first[:id]
  end

  def location
    photo_location = PhotoService.photo_lookup(photo_id)[:photo][:location]
    "#{photo_location[:region][:_content]}, #{photo_location[:locality][:_content]}"
  end

  def parsed_down_service_call
    photo_service = PhotoService.photo_lookup(photo_id)
    {
      url: photo_service[:photo][:urls][:url].first[:_content],
      location: location,
      source: "flickr.com",
      photographer: photo_service[:photo][:owner][:username],
      profile: "https://www.flickr.com/photos/#{photo_service[:photo][:owner][:nsid]}",
      title: photo_service[:photo][:title][:_content]
    }
  end

  def photo_object
    Photo.new(parsed_down_service_call)
  end
end
