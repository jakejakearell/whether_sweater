require 'rails_helper'

describe "User Creation" do
  describe 'Happy Paths' do
    it "can create a user" do
      body = {
                 email: 'jake@ihopethiswork.org',
                 password: 'h1tech',
                 password_confirmation: 'h1tech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }

      post "/api/v1/users", headers: headers, params: body, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      user_json = JSON.parse(response.body, symbolize_names: true)

      expect(user_json).to be_a(Hash)
      expect(user_json.keys.count).to eq(1)
      expect(user_json).to have_key(:data)
      expect(user_json[:data].keys.count).to eq(3)
      expect(user_json[:data]).to have_key(:id)
      expect(user_json[:data][:id]).to be_a(String)
      expect(user_json[:data]).to have_key(:type)
      expect(user_json[:data][:type]).to eq("user")
      expect(user_json[:data]).to have_key(:attributes)
      expect(user_json[:data][:attributes].count).to eq(2)
      expect(user_json[:data][:attributes]).to have_key(:api_key)
      expect(user_json[:data][:attributes][:api_key]).to be_a(String)
      expect(user_json[:data][:attributes]).to have_key(:email)
      expect(user_json[:data][:attributes][:email]).to eq(body[:email])
      expect(user_json[:data][:attributes][:email]).to be_a(String)
    end
  end

  describe 'Sad Paths' do
    it "will give a descriptive error if passwords don't match" do
      body = {
                email: 'jake@ihopethiswork.org',
                password: 'h1tech',
                password_confirmation: 'hItech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/users", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Passwords must match")
    end

    it "will give a descriptive error if password missing" do
      body = {
                 email: 'jake@ihopethiswork.org',
                 password: '',
                 password_confirmation: ''
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/users", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Password can't be blank")
    end

    it "will give a descriptive error if email missing" do
      body = {
                 email: '',
                 password: 'h1tech',
                 password_confirmation: 'h1tech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/users", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Email can't be blank")
    end

    it "will give a descriptive error if email taken" do
      User.create({email: 'jake@ihopethiswork.org',
         password: 'h1tech'})

      body = {
                 email: 'jake@ihopethiswork.org',
                 password: 'h1tech',
                 password_confirmation: 'h1tech'
               }

      headers = {"CONTENT_TYPE" => "application/json", 'ACCEPT' => 'application/json' }
      post "/api/v1/users", headers: headers, params: body, as: :json
      expect(response.status).to eq(404)

      user_json = JSON.parse(response.body, symbolize_names: true)
      expect(user_json[:error]).to eq("Email has already been taken")
    end
  end
end
