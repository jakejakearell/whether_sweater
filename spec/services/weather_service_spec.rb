require 'rails_helper'

RSpec.describe 'Geocoding Service' do
  describe 'Happy Paths' do

    it 'will establish a connection to the geocoding service' do
      VCR.use_cassette('weather_service_test') do
        service = WeatherService.current_forecast('Denver,CO')
        expect(service).to be_a(Hash)

        #information for current_weather
        expect(service).to have_key(:current)
        expect(service[:current]).to have_key(:dt)
        expect(service[:current][:dt]).to be_a(Integer)
        expect(service[:current]).to have_key(:sunrise)
        expect(service[:current][:sunrise]).to be_a(Integer)
        expect(service[:current]).to have_key(:sunset)
        expect(service[:current][:sunset]).to be_a(Integer)
        expect(service[:current]).to have_key(:temp)
        expect(service[:current][:temp]).to be_a(Float)
        expect(service[:current]).to have_key(:feels_like)
        expect(service[:current][:feels_like]).to be_a(Float)
        expect(service[:current]).to have_key(:humidity)
        expect(service[:current][:humidity]).to be_a(Integer)
        expect(service[:current]).to have_key(:uvi)
        expect(service[:current][:uvi]).to be_a(Float)
        expect(service[:current]).to have_key(:visibility)
        expect(service[:current][:visibility]).to be_a(Integer)
        expect(service[:current]).to have_key(:weather)
        expect(service[:current][:weather]).to be_a(Array)
        expect(service[:current][:weather].first).to be_a(Hash)
        expect(service[:current][:weather].first).to have_key(:description)
        expect(service[:current][:weather].first[:description]).to be_a(String)
        expect(service[:current][:weather].first).to have_key(:icon)
        expect(service[:current][:weather].first[:icon]).to be_a(String)

        #relevant info for the current weather info
        expect(service).to have_key(:daily)
        expect(service[:daily]).to be_a(Array)
        expect(service[:daily].count).to eq(8)

        service[:daily].each do |day|
          expect(day).to have_key(:dt)
          expect(day[:dt]).to be_a(Integer)
          expect(day).to have_key(:sunrise)
          expect(day[:sunrise]).to be_a(Integer)
          expect(day).to have_key(:sunset)
          expect(day[:sunset]).to be_a(Integer)
          expect(day).to have_key(:temp)
          expect(day[:temp]).to be_a(Hash)
          expect(day[:temp]).to have_key(:max)
          expect(day[:temp][:max]).to be_a_kind_of(Numeric)
          expect(day[:temp]).to have_key(:min)
          expect(day[:temp][:min]).to be_a_kind_of(Numeric)
          expect(day).to have_key(:weather)
          expect(day[:weather]).to be_a(Array)
          expect(day[:weather].first).to be_a(Hash)
          expect(day[:weather].first).to have_key(:description)
          expect(day[:weather].first[:description]).to be_a(String)
          expect(day[:weather].first).to have_key(:icon)
          expect(day[:weather].first[:icon]).to be_a(String)
        end

        #relevant info for the hourly weather info
        expect(service).to have_key(:daily)
        expect(service[:hourly]).to be_a(Array)
        expect(service[:hourly].count).to eq(48)

        service[:hourly].each do |hour|
          expect(hour).to have_key(:dt)
          expect(hour[:dt]).to be_a(Integer)
          expect(hour).to have_key(:temp)
          expect(hour[:temp]).to  be_a_kind_of(Numeric)
          expect(hour).to have_key(:weather)
          expect(hour[:weather]).to be_a(Array)
          expect(hour[:weather].first).to be_a(Hash)
          expect(hour[:weather].first).to have_key(:description)
          expect(hour[:weather].first[:description]).to be_a(String)
          expect(hour[:weather].first).to have_key(:icon)
          expect(hour[:weather].first[:icon]).to be_a(String)
        end
      end
    end
  end
end
