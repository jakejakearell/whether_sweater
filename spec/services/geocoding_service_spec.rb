require 'rails_helper'

RSpec.describe 'Geocoding Service' do

  describe 'Happy Paths' do

    it 'will establish a connection to the geocoding service' do

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
  end
end
