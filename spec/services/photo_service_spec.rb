require 'rails_helper'

RSpec.describe 'Photo Service' do
  describe 'Happy Paths' do
    it 'will connect to the photo service search' do
      VCR.use_cassette('photo_service_search_test') do
        service = PhotoService.photo_location_lat_lon_search("denver,co")

        expect(service).to be_a(Hash)
        expect(service).to have_key(:photos)
        expect(service[:photos]).to have_key(:photo)
        expect(service[:photos][:photo]).to be_a(Array)
        expect(service[:photos][:photo].first).to have_key(:id)
        expect(service[:photos][:photo].first[:id]).to be_a(String)
      end
    end

    it 'can use the photo api to look up a photo' do
      VCR.use_cassette('photo_service_lookup_test') do
        service = PhotoService.photo_lookup("6066076873")
        expect(service).to be_a(Hash)
        expect(service).to have_key(:photo)
        expect(service[:photo]).to have_key(:urls)
        expect(service[:photo][:urls]).to have_key(:url)
        expect(service[:photo][:urls][:url]).to be_a(Array)
        expect(service[:photo][:urls][:url].first).to have_key(:_content)
        expect(service[:photo][:urls][:url].first[:_content]).to be_a(String)
        expect(service[:photo]).to have_key(:owner)
        expect(service[:photo][:owner]).to have_key(:username)
        expect(service[:photo][:owner][:username]).to be_a(String)
        expect(service[:photo]).to have_key(:owner)
        expect(service[:photo][:owner]).to have_key(:nsid)
        expect(service[:photo][:owner][:nsid]).to be_a(String)
        expect(service[:photo]).to have_key(:title)
        expect(service[:photo][:title]).to have_key(:_content)
        expect(service[:photo][:title][:_content]).to be_a(String)
      end
    end
  end

  describe 'Sad Paths' do
    it 'can handle non string search' do
      VCR.use_cassette('photo_service_test_sad_paths') do
        service = PhotoService.photo_location_lat_lon_search(1234)

        expect(service).to be_a(Hash)
        expect(service).to have_key(:photos)
        expect(service[:photos]).to have_key(:photo)
        expect(service[:photos][:photo]).to be_a(Array)
        expect(service[:photos][:photo].first).to have_key(:id)
        expect(service[:photos][:photo].first[:id]).to be_a(String)
      end
    end

    it 'can handle nil search' do
      VCR.use_cassette('photo_service_test_sad_paths_nil') do
        service = PhotoService.photo_location_lat_lon_search(nil)

        expect(service).to be_a(Hash)
        expect(service).to have_key(:photos)
        expect(service[:photos]).to have_key(:photo)
        expect(service[:photos][:photo]).to be_a(Array)
        expect(service[:photos][:photo].count).to eq(0)
      end
    end
  end
end
