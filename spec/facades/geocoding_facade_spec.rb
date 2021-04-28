require 'rails_helper'

describe "Geocoding Facade" do
  describe 'Happy Paths' do
    it "will return a poro with latitude and longitude" do

      VCR.use_cassette("geocoding_facade_denver_parsed") do
        result = GeocodingFacade.new("Denver,CO").parse_service_call

        expect(result).to be_a(Hash)
        expect(result.count).to eq(2)
        expect(result).to have_key(:latitude)
        expect(result[:latitude]).to eq(39.738453)
        expect(result).to have_key(:longitude)
        expect(result[:longitude]).to eq((-104.984853))
      end
    end

    it "will return a poro with latitude and longitude" do

      VCR.use_cassette("geocoding_facade_denver") do
        result = GeocodingFacade.new("Denver,CO").latitude_longitude
        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(39.738453)
        expect(result.longitude).to eq((-104.984853))
      end
    end

  describe "Sad paths"
    it "will return a poro with location of northpole if no location given" do
      VCR.use_cassette("geocoding_facade_denver_sad_path") do
        result = GeocodingFacade.new(nil).check_service_call_status
        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(90)
        expect(result.longitude).to eq((135))
      end
    end
  end
end
