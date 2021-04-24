require 'rails_helper'

describe "Geocoding Facade" do
  describe 'Happy Paths' do
    it "will return a poro with latitude and longitude" do

      VCR.use_cassette("geocoding_facade_denver") do
        result = GeocodingFacade.latitude_longitude("Denver,CO")
        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(39.738453)
        expect(result.longitude).to eq((-104.984853))
      end
    end
  end
end
