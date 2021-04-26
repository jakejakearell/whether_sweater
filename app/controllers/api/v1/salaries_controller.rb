class Api::V1::SalariesController < ApplicationController

  def index
    render json: SalariesSerializer.new(salaries_object)
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
    collection = []
    json_parser(salaries.body)[:salaries].map do |salary|
      if targeted_jobs.include?(salary[:job][:title])
        collection << salary
      end
    end
    collection
  end

  def targeted_jobs
    ["Data Analyst","Data Scientist","Mobile Developer","QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
  end

  def format_salaries_information
    parse_salaries_api_call.reduce([]) do |memo, salary|
      info = {
        title: salary[:job][:title],
        min: salary[:salary_percentiles][:percentile_25],
        max: salary[:salary_percentiles][:percentile_75]
      }
      memo << info
      memo
    end
  end

  def weather_info
    WeatherFacade.new(destination).current_weather_salaries
  end

  def salaries_object
    Salaries.new(destination, format_salaries_information, weather_info)
  end
end
