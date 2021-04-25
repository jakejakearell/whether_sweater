class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :location, :photographer, :profile, :source

end
