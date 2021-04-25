class Api::V1::ForecastController < ApplicationController
  def index
    forecast_object = WeatherFacade.new(location).poro_creation
    render json: ForecastSerializer.new(forecast_object)
  end

  private

  def location
    params[:location]
  end
end
