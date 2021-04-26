require 'rails_helper'

describe "Salaries Facade" do
  describe 'Happy Paths' do
    before :each do
      @salary_facade = SalariesFacade.new('denver')
    end

    it "will collect only the targeted jobs" do
      expect(@salary_facade.targeted_jobs.count).to eq(7)
      expect(@salary_facade.parse_salaries_api_call.count).to eq(7)
      expect(@salary_facade.parse_salaries_api_call).to be_a(Array)

      @salary_facade.parse_salaries_api_call.each do |salary|
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

    it "format down the salaries further" do
      expect(@salary_facade.targeted_jobs.count).to eq(7)
      expect(@salary_facade.format_salaries_information.count).to eq(7)
      expect(@salary_facade.format_salaries_information).to be_a(Array)

      @salary_facade.format_salaries_information.each do |salary|
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

    it "format can get the temp for a destination" do
      weather = @salary_facade.weather_info

      expect(weather).to be_a(Hash)
      expect(weather.count).to eq(2)
      expect(weather).to have_key(:temperature)
      expect(weather[:temperature]).to be_a(String)
      expect(weather).to have_key(:summary)
      expect(weather[:summary]).to be_a(String)
    end

    it "can create a Salaries object" do
      object = @salary_facade.salaries_object

      expect(object).to be_a(Salaries)
    end
  end
end
