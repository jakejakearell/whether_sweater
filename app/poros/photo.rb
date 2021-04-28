class Photo
  attr_reader :title,
              :id,
              :url,
              :location,
              :photographer,
              :profile,
              :source

  def initialize(data = Hash.new)
    @id = "null"
    @title = data[:title]
    @url = data[:url]
    @location = data[:location]
    @photographer = data[:photographer]
    @profile = data[:profile]
    @source = data[:source]
  end
end
