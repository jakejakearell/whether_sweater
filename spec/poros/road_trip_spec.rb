require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'happy path' do
    before :each do
      VCR.use_cassette("road_trip_poro") do
        destination = {"origin"=>"Chicago,IL", "destination"=>"Pueblo,CO"}
        @result = RoadTripFacade.new(destination).make_poro
      end
    end

    it 'has attributes of current_weather, daily_weather, hourly_weather and is a RoadTrip object' do
      expect(@result).to be_a(RoadTrip)
      expect(@result.id).to eq("null")
      expect(@result.end_city).to eq("Pueblo,CO")
      expect(@result.start_city).to eq("Chicago,IL")
      expect(@result.travel_time).to be_a(String)
      expect(@result.weather_at_eta).to be_a(Hash)
      expect(@result.weather_at_eta.count).to eq(2)
      require "pry"; binding.pry
      expect(@result.weather_at_eta[:temperature]).to be_a(Float)
      expect(@result.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
