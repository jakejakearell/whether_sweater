require 'rails_helper'

describe "Roadtrip Endpoint" do
  before :each do
    body = {
      email: 'jake@ihopethiswork.org',
      password: 'h1tech',
      password_confirmation: 'h1tech'
    }
    headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
    post "/api/v1/users", headers: headers, params: body, as: :json
    @user = User.first
  end

  describe 'Happy Paths' do
    it "will return JSON with a proper request create a user" do
      body =  {
                "origin": "Denver,CO",
                "destination": "Pueblo,CO",
                "api_key": "#{@user.api_key}"
              }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }

      VCR.use_cassette("happy_path_local_trip") do
        post "/api/v1/road_trip", headers: headers, params: body, as: :json

        expect(response).to be_successful
        expect(response.status).to eq(200)

        road_trip_response = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip_response).to be_a(Hash)
        expect(road_trip_response).to have_key(:data)
        expect(road_trip_response[:data]).to be_a(Hash)
        expect(road_trip_response[:data]).to have_key(:id)
        expect(road_trip_response[:data][:id]).to eq("null")
        expect(road_trip_response[:data]).to have_key(:type)
        expect(road_trip_response[:data][:type]).to eq('road_trip')
        expect(road_trip_response[:data]).to have_key(:attributes)
        expect(road_trip_response[:data][:attributes]).to be_a(Hash)
        expect(road_trip_response[:data][:attributes].count).to eq(4)
        expect(road_trip_response[:data][:attributes]).to have_key(:start_city)
        expect(road_trip_response[:data][:attributes][:start_city]).to eq("Denver,CO")
        expect(road_trip_response[:data][:attributes]).to have_key(:end_city)
        expect(road_trip_response[:data][:attributes][:end_city]).to eq("Pueblo,CO")
        expect(road_trip_response[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip_response[:data][:attributes][:travel_time]).to be_a(String)
        expect(road_trip_response[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip_response[:data][:attributes][:weather_at_eta].count).to eq(2)
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a_kind_of(Numeric)
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(road_trip_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)

      end
    end
  end

  describe 'Sad Paths' do
    describe 'API key does not exist' do
      it "returns error message" do
        body =  {
                  "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": "123"
                }

        headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
        VCR.use_cassette("bad_login") do
          post "/api/v1/road_trip", headers: headers, params: body, as: :json
          expect(response.status).to eq(401)

          no_api = JSON.parse(response.body, symbolize_names: true)
          expect(no_api[:error]).to eq("Unauthorized")
        end
      end
    end

    describe 'destination will cannot be reached by car' do
      it "returns a JSON with impossible in several fields" do
        body =  {
                  "origin": "Denver,CO",
                  "destination": "London,UK",
                  "api_key": "#{@user.api_key}"
                }

        headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
        VCR.use_cassette("road_trip_not_passbable") do
          post "/api/v1/road_trip", headers: headers, params: body, as: :json
          expect(response.status).to eq(200)

          road_trip_response = JSON.parse(response.body, symbolize_names: true)

          expect(road_trip_response).to be_a(Hash)
          expect(road_trip_response).to have_key(:data)
          expect(road_trip_response[:data]).to be_a(Hash)
          expect(road_trip_response[:data]).to have_key(:id)
          expect(road_trip_response[:data][:id]).to eq("null")
          expect(road_trip_response[:data]).to have_key(:type)
          expect(road_trip_response[:data][:type]).to eq('road_trip')
          expect(road_trip_response[:data]).to have_key(:attributes)
          expect(road_trip_response[:data][:attributes]).to be_a(Hash)
          expect(road_trip_response[:data][:attributes].count).to eq(4)
          expect(road_trip_response[:data][:attributes]).to have_key(:start_city)
          expect(road_trip_response[:data][:attributes][:start_city]).to eq("Denver,CO")
          expect(road_trip_response[:data][:attributes]).to have_key(:end_city)
          expect(road_trip_response[:data][:attributes][:end_city]).to eq("London,UK")
          expect(road_trip_response[:data][:attributes]).to have_key(:travel_time)
          expect(road_trip_response[:data][:attributes][:travel_time]).to eq("impossible")
          expect(road_trip_response[:data][:attributes]).to have_key(:weather_at_eta)
          expect(road_trip_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(road_trip_response[:data][:attributes][:weather_at_eta].count).to eq(2)
          expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
          expect(road_trip_response[:data][:attributes][:weather_at_eta][:temperature]).to eq("impossible")
          expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
          expect(road_trip_response[:data][:attributes][:weather_at_eta][:conditions]).to eq("impossible")
        end
      end
    end

    describe 'bad params will throw return a message' do
      it "returns error message" do
        body =  {
                  "s": "23,12",
                  "sdasd": "123",
                  "api_key": "#{@user.api_key}"
                }

        headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
        VCR.use_cassette("road_trip_bad_body") do
          post "/api/v1/road_trip", headers: headers, params: body, as: :json
          expect(response.status).to eq(401)

          road_trip_response = JSON.parse(response.body, symbolize_names: true)

          expect(road_trip_response[:error]).to eq("Bad Params")
        end
      end

      it "returns error message" do
        body =  nil
        headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
        VCR.use_cassette("no body") do
          post "/api/v1/road_trip", headers: headers, params: body, as: :json
          expect(response.status).to eq(401)

          road_trip_response = JSON.parse(response.body, symbolize_names: true)

          expect(road_trip_response[:error]).to eq("Missing Params")
        end
      end
    end
  end
end
