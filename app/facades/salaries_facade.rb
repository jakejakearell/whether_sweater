class SalariesFacade
  include ActionView::Helpers::NumberHelper
  attr_reader :targeted_jobs

  def initialize(destination)
    @service_call = SalariesService.salaries(destination)
    @targeted_jobs = ["Data Analyst","Data Scientist","Mobile Developer","QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
    @destination = destination
  end

  def format_salaries_information
    parse_salaries_api_call.reduce([]) do |memo, salary|

      info = {
        title: salary[:job][:title],
        min: number_to_currency(salary[:salary_percentiles][:percentile_25]),
        max: number_to_currency(salary[:salary_percentiles][:percentile_75])
      }

      memo << info
      memo
    end
  end

  def parse_salaries_api_call
    @service_call[:salaries].reduce([]) do |memo, salary|
      if @targeted_jobs.include?(salary[:job][:title])
        memo << salary
      end
      memo
    end
  end

  def weather_info
    WeatherFacade.new(@destination).current_weather_salaries
  end

  def salaries_object
    Salaries.new(@destination, format_salaries_information, weather_info)
  end
end
