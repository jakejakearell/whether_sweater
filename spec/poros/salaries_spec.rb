require 'rails_helper'

RSpec.describe Salaries do
  describe 'happy path' do
    it 'has expected attributes' do
      result = SalariesFacade.new("denver").salaries_object

      expect(result).to be_a(Salaries)
      expect(result.id).to eq("null")

      expect(result.salaries).to be_a(Array)
      expect(result.salaries.count).to eq(7)
      result.salaries.each do |salary|
        expect(salary).to be_a(Hash)
        expect(salary.count).to eq(3)
        expect(salary).to have_key(:title)
        expect(salary[:title]).to be_a(String)
        expect(salary).to have_key(:min)
        expect(salary[:min]).to be_a(String)
        expect(salary).to have_key(:max)
        expect(salary[:max]).to be_a(String)
      end

      expect(result.destination).to eq('denver')

      expect(result.forecast).to be_a(Hash)
      expect(result.forecast.count).to eq(2)
      expect(result.forecast).to have_key(:temperature)
      expect(result.forecast[:temperature]).to be_a(String)
      expect(result.forecast).to have_key(:summary)
      expect(result.forecast[:summary]).to be_a(String)

    end
  end
end
