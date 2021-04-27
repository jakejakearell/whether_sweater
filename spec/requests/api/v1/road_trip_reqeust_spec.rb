require 'rails_helper'

describe "User Creation" do
  describe 'Happy Paths' do
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

    it "can create a user" do
      body =  {
                "origin": "Denver,CO",
                "destination": "Pueblo,CO",
                "api_key": "#{@user.api_key}"
              }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }

      post "/api/v1/road_trip", headers: headers, params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(204)
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
        post "/api/v1/road_trip", headers: headers, params: body, as: :json
        expect(response.status).to eq(404)

        user_json = JSON.parse(response.body, symbolize_names: true)
        expect(user_json[:error]).to eq("Request Bad")
      end
    end
  end
end
