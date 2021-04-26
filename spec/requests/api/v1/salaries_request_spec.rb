require 'rails_helper'

describe "Salaries endpoint" do
  describe 'Happy Paths' do
    it "retrieves salaires and forecast for a city valid location" do

      get '/api/v1/salaries?destination=denver'

      expect(response).to be_successful

      # salaires = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
