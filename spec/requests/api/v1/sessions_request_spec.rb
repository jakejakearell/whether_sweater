require 'rails_helper'

RSpec.describe "Sessions request spec" do
  describe 'Happy Paths' do
    before :each do
      body = {
                 email: 'jake@ihopethiswork.org',
                 password: 'h1tech',
                 password_confirmation: 'h1tech'
               }
      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/users", headers: headers, params: body, as: :json
    end

    it "can log in with the correct credientals" do
      body = {
                 email: 'jake@ihopethiswork.org',
                 password: 'h1tech'
               }
      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }

      post "/api/v1/sessions", headers: headers, params: body, as: :json
      expect(response).to be_successful
      expect(response.status).to eq(200)

      sessions_json = JSON.parse(response.body, symbolize_names: true)

      expect(sessions_json).to be_a(Hash)
      expect(sessions_json.keys.count).to eq(1)
      expect(sessions_json).to have_key(:data)
      expect(sessions_json[:data].keys.count).to eq(3)
      expect(sessions_json[:data]).to have_key(:id)
      expect(sessions_json[:data][:id]).to be_a(String)
      expect(sessions_json[:data]).to have_key(:type)
      expect(sessions_json[:data][:type]).to eq("user")
      expect(sessions_json[:data]).to have_key(:attributes)
      expect(sessions_json[:data][:attributes].count).to eq(2)
      expect(sessions_json[:data][:attributes]).to have_key(:api_key)
      expect(sessions_json[:data][:attributes][:api_key]).to be_a(String)
      expect(sessions_json[:data][:attributes]).to have_key(:email)
      expect(sessions_json[:data][:attributes][:email]).to eq(body[:email])
      expect(sessions_json[:data][:attributes][:email]).to be_a(String)
    end
  end
  describe 'Sad Paths' do
    it "will give a non-descriptive error if passwords don't match" do
      body = {
                email: 'jake@ihopethiswork.org',
                password: 'iamthehackman'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/sessions", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Request Bad")
    end

    it "will give a non-descriptive error if password missing" do
      body = {
                 email: 'jake@ihopethiswork.org',
                 password: ''
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/sessions", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Request Bad")
    end

    it "will give a non-descriptive error if email missing" do
      body = {
                 email: '',
                 password: 'h1tech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/sessions", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Request Bad")
    end

    it "will give a non-descriptive error if email taken" do

      body = {
                 email: 'Fake@ihopethiswork.org',
                 password: 'h1tech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/sessions", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Request Bad")
    end
  end
end
