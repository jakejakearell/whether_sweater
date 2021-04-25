require 'rails_helper'

describe "Retrieve weather for a city" do
  describe 'Happy Paths' do
    it "retrieves weather info with valid location" do
      VCR.use_cassette('forecast_endpoint') do
        get '/api/v1/forecast?location=denver,co'

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(weather).to be_a(Hash)
        expect(weather).to have_key(:data)
        expect(weather[:data]).to be_a(Hash)

        expect(weather[:data]).to have_key(:id)
        expect(weather[:data][:id]).to eq("null")

        expect(weather[:data]).to have_key(:type)
        expect(weather[:data][:type]).to eq('forecast')

        expect(weather[:data]).to have_key(:attributes)

        expect(weather[:data][:attributes]).to have_key(:current_weather)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:datetime)
        expect(weather[:data][:attributes][:current_weather][:datetime]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:temperature)
        expect(weather[:data][:attributes][:current_weather][:temperature]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:feels_like)
        expect(weather[:data][:attributes][:current_weather][:feels_like]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:humidity)
        expect(weather[:data][:attributes][:current_weather][:humidity]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:uvi)
        expect(weather[:data][:attributes][:current_weather][:uvi]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:visibility)
        expect(weather[:data][:attributes][:current_weather][:visibility]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:conditions)
        expect(weather[:data][:attributes][:current_weather][:conditions]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:icon)
        expect(weather[:data][:attributes][:current_weather][:icon]).to be_a(String)

        expect(weather[:data][:attributes]).to have_key(:daily_weather)
        expect(weather[:data][:attributes][:daily_weather].count).to eq(5)
        weather[:data][:attributes][:daily_weather].each do  |daily_weather|
          expect(daily_weather).to have_key(:date)
          expect(daily_weather[:date]).to be_a(String)
          expect(daily_weather).to have_key(:sunrise)
          expect(daily_weather[:sunrise]).to be_a(String)
          expect(daily_weather).to have_key(:sunset)
          expect(daily_weather[:sunset]).to be_a(String)
          expect(daily_weather).to have_key(:max_temp)
          expect(daily_weather[:max_temp]).to be_a_kind_of(Numeric)
          expect(daily_weather).to have_key(:min_temp)
          expect(daily_weather[:min_temp]).to be_a_kind_of(Numeric)
          expect(daily_weather).to have_key(:conditions)
          expect(daily_weather[:conditions]).to be_a(String)
          expect(daily_weather).to have_key(:icon)
          expect(daily_weather[:icon]).to be_a(String)
        end

        expect(weather[:data][:attributes]).to have_key(:hourly_weather)
        expect(weather[:data][:attributes][:hourly_weather].count).to eq(8)
        weather[:data][:attributes][:hourly_weather].each do  |hourly_weather|
          expect(hourly_weather).to have_key(:time)
          expect(hourly_weather[:time]).to be_a(String)
          expect(hourly_weather).to have_key(:temperature)
          expect(hourly_weather[:temperature]).to be_a_kind_of(Numeric)
          expect(hourly_weather).to have_key(:conditions)
          expect(hourly_weather[:conditions]).to be_a(String)
          expect(hourly_weather).to have_key(:icon)
          expect(hourly_weather[:icon]).to be_a(String)
        end
      end
    end
  end

  describe 'Sad Paths' do
    it "gives error when an empty location is used" do
      VCR.use_cassette('forecast_endpoint_sad_path') do
        get '/api/v1/forecast?location='

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(weather[:status]).to eq(404)
        expect(weather[:error]).to eq("Must Enter a location")
      end
    end
  end
end
