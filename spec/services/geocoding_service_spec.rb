require 'rails_helper'

RSpec.describe 'Geocoding Service' do
  describe 'Happy Paths' do

    it 'will establish a connection to the geocoding service for a location' do
      VCR.use_cassette('geocoding_service_test') do
        service = GeocodingService.address_cordinates('Denver,CO')
        expect(service).to be_a(Hash)
        expect(service).to have_key(:results)
        expect(service[:results]).to be_a(Array)
        expect(service[:results].first).to have_key(:locations)
        expect(service[:results].first[:locations]).to be_a(Array)
        expect(service[:results].first[:locations].first).to have_key(:latLng)
        expect(service[:results].first[:locations].first[:latLng]).to have_key(:lat)
        expect(service[:results].first[:locations].first[:latLng]).to have_key(:lng)
        expect(service[:results].first[:locations].first[:latLng][:lat]).to eq(39.738453)
        expect(service[:results].first[:locations].first[:latLng][:lng]).to eq((-104.984853))
      end
    end

    it 'will establish a connection to the geocoding service for a roadtrip' do
      VCR.use_cassette('geocoding_road_trip_service') do
        destination = {"origin"=>"Denver,CO", "destination"=>"Pueblo,CO"}
        service = GeocodingService.road_trip(destination)
        expect(service).to be_a(Hash)
        expect(service).to have_key(:route)
        expect(service[:route]).to be_a(Hash)
        expect(service[:route]).to have_key(:formattedTime)
        expect(service[:route][:formattedTime]).to be_a(String)
        expect(service[:route]).to have_key(:time)
        expect(service[:route][:time]).to be_a(Integer)
        expect(service[:route]).to have_key(:routeError)
        expect(service[:route][:routeError]).to have_key(:errorCode)
        expect(service[:route][:routeError][:errorCode]).to eq(-400)
      end
    end
  end

  describe 'Sad Paths' do
    it 'will still return lat and long with a non-standard request' do
      VCR.use_cassette('geocoding_service_test_sad_paths') do
        service = GeocodingService.address_cordinates("1234,asd afd dsdfas {}}][[[[[!!!!]]]]]")
        expect(service).to be_a(Hash)
        expect(service).to have_key(:results)
        expect(service[:results]).to be_a(Array)
        expect(service[:results].first).to have_key(:locations)
        expect(service[:results].first[:locations]).to be_a(Array)
        expect(service[:results].first[:locations].first).to have_key(:latLng)
        expect(service[:results].first[:locations].first[:latLng]).to have_key(:lat)
        expect(service[:results].first[:locations].first[:latLng]).to have_key(:lng)
        expect(service[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
        expect(service[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      end
    end

    it 'will will have an error for an impossible route' do
      VCR.use_cassette('bad_location_geocoding_road_trip_service') do
        destination = {"origin"=>"New York, NY", "destination"=>"London,UK"}

        service = GeocodingService.road_trip(destination)
        expect(service).to be_a(Hash)
        expect(service).to have_key(:info)
        expect(service[:info]).to have_key(:messages)
        expect(service[:info][:messages]).to be_a(Array)
        expect(service[:info][:messages].first).to eq("We are unable to route with the given locations.")
        expect(service).to have_key(:route)
        expect(service[:route]).to be_a(Hash)
        expect(service[:route]).to have_key(:routeError)
        expect(service[:route][:routeError]).to have_key(:errorCode)
        expect(service[:route][:routeError][:errorCode]).to eq(2)
      end
    end

    it 'will will have an error for an one destination' do
      VCR.use_cassette('one_location_geocoding_road_trip_service') do
        destination = {"origin"=>"New York, NY", "destination"=>""}
        service = GeocodingService.road_trip(destination)
        expect(service).to be_a(Hash)
        expect(service).to have_key(:info)
        expect(service[:info]).to have_key(:messages)
        expect(service[:info][:messages]).to be_a(Array)
        expect(service[:info][:messages].first).to eq("At least two locations must be provided.")
        expect(service).to have_key(:route)
        expect(service[:route]).to be_a(Hash)
        expect(service[:route]).to have_key(:routeError)
        expect(service[:route][:routeError]).to have_key(:errorCode)
        expect(service[:route][:routeError][:errorCode]).to eq(211)
      end
    end

  end
end
