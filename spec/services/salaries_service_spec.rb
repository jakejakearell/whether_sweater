require 'rails_helper'

RSpec.describe 'Salaries Service' do
  describe 'Happy Paths' do
    it 'will establish a connection to the salaries service' do

      service = SalariesService.salaries('denver')

      expect(service).to be_a(Hash)
      expect(service).to have_key(:salaries)
      expect(service[:salaries].count).to eq(52)
      expect(service[:salaries]).to be_a(Array)

      service[:salaries].each do |salary|
        expect(salary).to be_a(Hash)
        expect(salary.count).to eq(2)
        expect(salary).to have_key(:job)
        expect(salary[:job]).to be_a(Hash)
        expect(salary[:job]).to have_key(:title)
        expect(salary[:job][:title]).to be_a(String)
        expect(salary).to have_key(:salary_percentiles)
        expect(salary[:salary_percentiles]).to have_key(:percentile_25)
        expect(salary[:salary_percentiles][:percentile_25]).to be_a(Float)
        expect(salary[:salary_percentiles]).to have_key(:percentile_75)
        expect(salary[:salary_percentiles][:percentile_75]).to be_a(Float)
      end
    end
  end
end
