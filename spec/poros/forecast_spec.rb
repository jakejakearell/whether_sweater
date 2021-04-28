require 'rails_helper'

RSpec.describe Forecast do
  describe 'happy path' do
    it 'has attributes of current_weather, daily_weather, hourly_weather and is a Forecast object' do
      VCR.use_cassette("forecast_poro") do
        result = WeatherFacade.new("mead,co").poro_creation

        expect(result).to be_a(Forecast)
        expect(result.id).to eq("null")
        expect(result.current_weather).to be_a(Hash)
        expect(result.current_weather.keys.count).to eq(10)
        expect(result.daily_weather).to be_a(Array)
        expect(result.daily_weather.count).to eq(5)
        expect(result.hourly_weather).to be_a(Array)
        expect(result.hourly_weather.count).to eq(8)
      end
    end
  end

  describe 'sad paths' do
    it 'has attributes of current_weather, daily_weather, hourly_weather and is a Forecast object' do
      VCR.use_cassette("forecast_poro_sad") do
        result = Forecast.new(nil, nil, nil)

        expect(result).to be_a(Forecast)
        expect(result.id).to eq("null")
        expect(result.current_weather).to eq(nil)
        expect(result.daily_weather).to eq(nil)
        expect(result.hourly_weather).to eq(nil)
      end
    end
  end
end
