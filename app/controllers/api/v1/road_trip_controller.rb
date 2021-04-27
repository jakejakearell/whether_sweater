class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      # RoadTripFacade.new(params[:origin], params[:destination]).trip
    else
      render json: {error: "Request Bad",status: 404}, status: 404
    end
  end
end
