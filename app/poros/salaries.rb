class Salaries

  attr_reader :destination,
              :id,
              :salaries,
              :forecast


  def initialize(destination,salaries,forecast)
    @id = "null"
    @destination = destination
    @salaries = salaries
    @forecast = forecast
  end
end
