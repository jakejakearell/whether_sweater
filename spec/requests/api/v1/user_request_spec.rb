require 'rails_helper'

describe "User Creation" do
  describe 'Happy Paths' do
    it "can create a user" do
      user_params = ({
                 email: 'jake@ihopethiswork.org',
                 password: 'h1tech',
                 password_confitmation: 'h1tech'
               })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/users", headers: headers, params: JSON.generate(item: user_params)
    end
  end
end
