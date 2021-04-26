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

      expect(salaries[:data][:attributes]).to have_key(:forecast)
      expect(salaries[:data][:attributes][:forecast]).to be_a(Hash)
      expect(salaries[:data][:attributes][:forecast].count).to eq(2)
      expect(salaries[:data][:attributes][:forecast]).to have_key(:summary)
      expect(salaries[:data][:attributes][:forecast][:summary]).to be_a(String)

      expect(salaries[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(salaries[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(salaries[:data][:attributes]).to have_key(:salaries)
      expect(salaries[:data][:attributes][:salaries]).to be_a(Array)
      expect(salaries[:data][:attributes][:salaries].count).to eq(7)

      salaries[:data][:attributes][:salaries].each do |salary|
        expect(salary).to be_a(Hash)
        expect(salary.count).to eq(3)
        expect(salary).to have_key(:title)
        expect(salary[:title]).to be_a(String)
        expect(salary).to have_key(:min)
        expect(salary[:min]).to be_a(String)
        expect(salary).to have_key(:max)
        expect(salary[:max]).to be_a(String)
      end
    end
  end
end
