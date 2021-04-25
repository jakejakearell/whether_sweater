class Api::V1::BackgroundsController < ApplicationController

  def index
    image_object = PhotoFacade.new(location).photo_object
    render json: ImageSerializer.new(image_object)
  end

  private

  def location
    params[:location]
  end
end
