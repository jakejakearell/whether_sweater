class Api::V1::SalariesController < ApplicationController
  def index
    salaries_object = SalariesFacade.new(destination).salaries_object
    render json: SalariesSerializer.new(salaries_object)
  end

  private

  def destination
    params[:destination]
  end
end
