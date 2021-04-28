require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'happy path' do
    before :each do
      VCR.use_cassette("road_trip_poro") do
        destination = {"origin"=>"Chicago,IL", "destination"=>"Santa Cruz,NM"}
        @result = RoadTripFacade.new(destination).assess_road_trip_viability
      end
    end

    it 'has attributes of current_weather, daily_weather, hourly_weather and is a RoadTrip object' do
      expect(@result).to be_a(RoadTrip)
      expect(@result.id).to eq("null")
      expect(@result.end_city).to eq("Santa Cruz,NM")
      expect(@result.start_city).to eq("Chicago,IL")
      expect(@result.travel_time).to be_a(String)
      expect(@result.weather_at_eta).to be_a(Hash)
      expect(@result.weather_at_eta.count).to eq(2)
      expect(@result.weather_at_eta[:temperature]).to be_a(Float)
      expect(@result.weather_at_eta[:conditions]).to be_a(String)
    end
  end

  describe 'sad path' do
    before :each do
      VCR.use_cassette("road_trip_poro_sad") do
        @result_2 = RoadTrip.new(nil, nil)
      end
    end

    it 'has attributes of current_weather, daily_weather, hourly_weather and is a RoadTrip object' do
      expect(@result_2).to be_a(RoadTrip)
      expect(@result_2.id).to eq("null")
      expect(@result_2.end_city).to eq("none")
      expect(@result_2.start_city).to eq("none")
      expect(@result_2.travel_time).to eq(nil)
      expect(@result_2.weather_at_eta).to be_a(Hash)
      expect(@result_2.weather_at_eta.count).to eq(2)
      expect(@result_2.weather_at_eta[:temperature]).to eq("impossible")
      expect(@result_2.weather_at_eta[:conditions]).to eq("impossible")
    end
  end
end
