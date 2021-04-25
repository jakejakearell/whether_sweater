require 'rails_helper'

describe "Retrieve a photo based on a location" do
  describe 'Happy Paths' do
    it "retrieves weather info with valid location" do
      VCR.use_cassette('backgrounds_endpoint') do
        get '/api/v1/backgrounds?location=denver,co'
        expect(response).to be_successful

        photo = JSON.parse(response.body, symbolize_names: true)

        expect(photo).to be_a(Hash)
        expect(photo).to have_key(:data)
        expect(photo[:data]).to be_a(Hash)
        expect(photo[:data]).to have_key(:id)
        expect(photo[:data][:id]).to eq("null")
        expect(photo[:data]).to have_key(:type)
        expect(photo[:data][:type]).to eq('image')
        expect(photo[:data]).to have_key(:attributes)
        expect(photo[:data][:attributes].keys.count).to eq(6)
        expect(photo[:data][:attributes]).to have_key(:title)
        expect(photo[:data][:attributes][:title]).to be_a(String)
        expect(photo[:data][:attributes]).to have_key(:url)
        expect(photo[:data][:attributes][:url]).to be_a(String)
        expect(photo[:data][:attributes]).to have_key(:location)
        expect(photo[:data][:attributes][:location]).to be_a(String)
        expect(photo[:data][:attributes]).to have_key(:photographer)
        expect(photo[:data][:attributes][:photographer]).to be_a(String)
        expect(photo[:data][:attributes]).to have_key(:profile)
        expect(photo[:data][:attributes][:profile]).to be_a(String)
        expect(photo[:data][:attributes]).to have_key(:source)
        expect(photo[:data][:attributes][:source]).to be_a(String)

      end
    end
  end

  describe 'Sad Paths' do
    it "gives error when an empty location is used" do
      VCR.use_cassette('backgrounds_endpoint_sad_path') do
        get '/api/v1/backgrounds?location='
        weather = JSON.parse(response.body, symbolize_names: true)

        expect(weather[:status]).to eq(404)
        expect(weather[:error]).to eq("Must Enter a location")

      end
    end
  end
end
