require 'rails_helper'

describe "User Creation" do
  describe 'Happy Paths' do
    it "can create a user" do
      body =  {
                "origin": "Denver,CO",
                "destination": "Pueblo,CO",
                "api_key": "jgn983hy48thw9begh98h4539h4"
              }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }

      post "/api/v1/forecast", headers: headers, params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
