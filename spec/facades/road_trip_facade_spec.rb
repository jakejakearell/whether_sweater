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

      end
    end

    it "make a road_trip poro" do
      VCR.use_cassette("can make poro") do
        lets_see = @road_trip_instance.assess_road_trip_viability

      end
    end

  end
  describe "Sad paths do" do
    xit "will return an error if an invalid location is used" do
    end

    xit "will return an empty object if there are no " do
    end
  end
end
