class Api::V1::ForecastController < ApplicationController
  def index
    if location.empty?
      render json: {error: "Must Enter a location",status: 404}, status: 404
    else
      forecast_object = WeatherFacade.new(location).poro_creation
      render json: ForecastSerializer.new(forecast_object)
    end
  end

  private

  def location
    params[:location]
  end
end
