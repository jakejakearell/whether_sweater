require 'rails_helper'

RSpec.describe GeocodedObject do
  describe 'happy path' do
    it 'has attributes of latitude, longitude and is a GeocodedObject object' do
      VCR.use_cassette("geocode_poro") do
        result = GeocodingFacade.new("Mead,CO").latitude_longitude

        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(40.237428)
        expect(result.longitude).to eq(-104.998668)
      end
    end
  end

  describe 'sad path' do
    it 'will create a poro when not given an argument' do
      VCR.use_cassette("geocode_poro_sad_path") do
        result = GeocodedObject.new()

        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(nil)
        expect(result.longitude).to eq(nil)
      end
    end
  end
end
