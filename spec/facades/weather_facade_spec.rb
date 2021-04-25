require 'rails_helper'

describe "Weather Facade" do
  describe 'Happy Paths' do
    before :each do
      VCR.use_cassette("weather_facade_instance") do
        @weather_facade_instance = WeatherFacade.new("Denver,CO")
      end
    end

    it "current_weather_attribute will return a hash of current weather data" do
      VCR.use_cassette("current_weather_facade_denver") do

        current_weather = @weather_facade_instance.current_weather_attribute
        expect(current_weather.keys.count).to eq(10)
        expect(current_weather).to have_key(:datetime)
        expect(current_weather[:datetime]).to be_a(Time)
        expect(current_weather).to have_key(:sunrise)
        expect(current_weather[:sunrise]).to be_a(Time)
        expect(current_weather).to have_key(:sunset)
        expect(current_weather[:sunset]).to be_a(Time)
        expect(current_weather).to have_key(:temperature)
        expect(current_weather[:temperature]).to be_a_kind_of(Numeric)
        expect(current_weather).to have_key(:feels_like)
        expect(current_weather[:feels_like]).to be_a_kind_of(Numeric)
        expect(current_weather).to have_key(:humidity)
        expect(current_weather[:humidity]).to be_a_kind_of(Numeric)
        expect(current_weather).to have_key(:uvi)
        expect(current_weather[:uvi]).to be_a_kind_of(Numeric)
        expect(current_weather).to have_key(:visibility)
        expect(current_weather[:visibility]).to be_a_kind_of(Numeric)
        expect(current_weather).to have_key(:conditions)
        expect(current_weather[:conditions]).to be_a(String)
        expect(current_weather).to have_key(:icon)
        expect(current_weather[:icon]).to be_a(String)

      end
    end

    it "daily_weather_attribute will return a hash of daily weather data" do
      VCR.use_cassette("daily_weather_facade_denver") do
        daily_weather = @weather_facade_instance.daily_weather_attribute
        expect(daily_weather.count).to eq(5)

        daily_weather.each do |day|
          expect(day.keys.count).to eq(7)
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(Time)
          expect(day).to have_key(:sunrise)
          expect(day[:sunrise]).to be_a(Time)
          expect(day).to have_key(:sunset)
          expect(day[:sunset]).to be_a(Time)
          expect(day).to have_key(:max_temp)
          expect(day[:max_temp]).to be_a_kind_of(Numeric)
          expect(day).to have_key(:min_temp)
          expect(day[:min_temp]).to be_a_kind_of(Numeric)
          expect(day).to have_key(:conditions)
          expect(day[:conditions]).to be_a(String)
          expect(day).to have_key(:icon)
          expect(day[:icon]).to be_a(String)
        end
      end
    end

    it "hourly_weather_attribute will return a hash of hourly weather data" do
      VCR.use_cassette("hourly_weather_facade_denver") do
        hourly_weather = @weather_facade_instance.hourly_weather_attribute
        expect(hourly_weather.count).to eq(8)

        hourly_weather.each do |hour|
          expect(hour.keys.count).to eq(4)
          expect(hour).to have_key(:time)
          expect(hour[:time]).to be_a(Time)
          expect(hour).to have_key(:temperature)
          expect(hour[:temperature]).to be_a_kind_of(Numeric)
          expect(hour).to have_key(:conditions)
          expect(hour[:conditions]).to be_a(String)
          expect(hour).to have_key(:icon)
          expect(hour[:icon]).to be_a(String)
        end
      end
    end

    it "poro creation will return a Forecast object with attributes" do
      VCR.use_cassette("weather_facade_poro") do
        weather_facade_poro = @weather_facade_instance.poro_creation
        expect(weather_facade_poro).to be_a(Forecast)
      end
    end
  end
end
