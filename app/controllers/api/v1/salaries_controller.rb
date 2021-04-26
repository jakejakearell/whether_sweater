class Api::V1::SalariesController < ApplicationController

  def index
    test = json_parser(salaries.body)
    parse_salaries_api_call
    require "pry"; binding.pry
  end

  private

  def salaries
    Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{destination}/salaries/")
  end

  def destination
    params[:destination]
  end

  def conn
    Faraday.new('https://api.teleport.org/api')
  end

  def json_parser(body)
    JSON.parse(body, symbolize_names: true)
  end

  def parse_salaries_api_call
    json_parser(salaries.body)[:salaries].each do |salary|
      require "pry"; binding.pry
    end
  end

  def targeted_jobs
    ["Data Analyst","Data Scientist","Mobile Developer","QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
  end 
end
