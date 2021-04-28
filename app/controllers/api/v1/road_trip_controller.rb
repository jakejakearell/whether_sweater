class Api::V1::RoadTripController < ApplicationController
  def create
    begin
      if user && road_trip
        render json: RoadTripSerializer.new(road_trip)
      elsif road_trip == false
        render json: {error: "Bad Params",status: 401}, status: 401
      else
        render json: {error: "Unauthorized",status: 401}, status: 401
      end
    rescue ActionController::ParameterMissing
      render json: {error: "Missing Params",status: 401}, status: 401
    end
  end

  private

  def user
    User.find_by(api_key: params[:api_key])
  end

  def road_trip
    RoadTripFacade.new(destination_and_origin).assess_road_trip_viability
  end

  def destination_and_origin
    params.require(:road_trip).permit(:origin, :destination)
  end
end
