require 'rails_helper'

describe "Salaries endpoint" do
  describe 'Happy Paths' do
    it "retrieves salaires and forecast for a city valid location" do

      get '/api/v1/salaries?destination=denver'

      expect(response).to be_successful

      salaries = JSON.parse(response.body, symbolize_names: true)

      expect(salaries).to be_a(Hash)
      expect(salaries.count).to eq(1)
      expect(salaries).to have_key(:data)
      expect(salaries[:data]).to be_a(Hash)
      expect(salaries[:data].count).to eq(3)
      expect(salaries[:data]).to have_key(:id)
      expect(salaries[:data][:id]).to eq("null")
      expect(salaries[:data]).to have_key(:type)
      expect(salaries[:data][:type]).to eq('salaries')
      expect(salaries[:data]).to have_key(:attributes)
      expect(salaries[:data][:attributes].count).to eq(3)
      expect(salaries[:data][:attributes]).to have_key(:destination)
      expect(salaries[:data][:attributes][:destination].count).to eq(1)
      expect(salaries[:data][:attributes][:destination]).to eq('denver')

    end
  end
end
