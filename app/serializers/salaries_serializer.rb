class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :salaries, :forecast, :destination
end
