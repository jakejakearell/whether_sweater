class Api::V1::BackgroundsController < ApplicationController

  def index
    if location.empty?
      render json: {error: "Must Enter a location",status: 404}, status: 404
    else
      image_object = PhotoFacade.new(location).photo_object
      render json: ImageSerializer.new(image_object)
    end
  end

  private

  def location
    params[:location]
  end
end
