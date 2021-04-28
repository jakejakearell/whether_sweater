require 'rails_helper'

describe "Road Trip Facade" do
  describe 'Happy Paths' do
    before :each do
      VCR.use_cassette("road_trip_facade_instance") do
        destination = {"origin"=>"Denver,CO", "destination"=>"Pueblo,CO"}
        @road_trip_instance = RoadTripFacade.new(destination)
      end
    end

    it "will choose weather forcast for the most recent hour" do
      VCR.use_cassette("time_selection") do
        eta = @road_trip_instance.eta
        destination_weather_time = @road_trip_instance.choose_time[:dt]
        weather_times = @road_trip_instance.forty_eight_hours_of_forecast

        times = weather_times.map do |time|
          (time[:dt] - eta).abs
        end

        smallest_difference = times.min_by {|time| time}

        closest_forecast_time = (destination_weather_time - eta).abs

        expect(smallest_difference).to eq(closest_forecast_time)
      end
    end

    it "will make a road_trip poro if trip is viable" do
      VCR.use_cassette("can make poro") do
        poro = @road_trip_instance.assess_road_trip_viability
        expect(poro).to be_a(RoadTrip)
      end
    end

    it "eta is a integer" do
      expect(@road_trip_instance.eta).to be_a(Integer)
    end

    it "route time is a string" do
      expect(@road_trip_instance.route_time).to be_a(String)
    end

    it "forty_eight_hours_of_forecast" do
      VCR.use_cassette("road_trip_forecast") do
        expect(@road_trip_instance.forty_eight_hours_of_forecast).to be_a(Array)
        expect(@road_trip_instance.forty_eight_hours_of_forecast.count).to eq(48)
      end
    end
  end

  describe "Sad paths do" do
    it "will recognize if no destination is present and return false" do
      VCR.use_cassette("road_trip_facade_instance_sad") do
        destination = {}
        @road_trip_instance = RoadTripFacade.new(destination)
        expect(@road_trip_instance.assess_road_trip_viability).to be(false)
      end
    end

    it "will recognize if a roadtrip isn't possible and return a poro reflecting this" do
      VCR.use_cassette("road_trip_facade_instance_impossible") do
        destination = {"origin"=>"Denver,CO", "destination"=>"London,UK"}
        @road_trip_instance = RoadTripFacade.new(destination)
        expect(@road_trip_instance.assess_road_trip_viability).to be_a(RoadTrip)
        expect(@road_trip_instance.assess_road_trip_viability.travel_time).to eq("impossible")
      end
    end
  end
end
