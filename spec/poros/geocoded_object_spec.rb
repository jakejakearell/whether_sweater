require 'rails_helper'

RSpec.describe GeocodedObject do
  describe 'happy path' do
    it 'has attributes of latitude, longitude and is a GeocodedObject object' do
      VCR.use_cassette("geocode_poro") do
        data = GeocodingService.address_cordinates("Mead,CO")

        result = GeocodedObject.new(data)

        expect(result).to be_a(GeocodedObject)
        expect(result.latitude).to eq(40.237428)
        expect(result.longitude).to eq(-104.998668)
      end
    end
  end
end
