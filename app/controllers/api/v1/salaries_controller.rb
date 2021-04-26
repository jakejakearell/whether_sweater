class Api::V1::SalariesController < ApplicationController
  def index
    if destination.empty?
      render json: {error: "Must Enter a location",status: 404}, status: 404
    else
      salaries_object = SalariesFacade.new(destination).salaries_object
      render json: SalariesSerializer.new(salaries_object)
    end
  end

  private

  def destination
    params[:destination]
  end
end
