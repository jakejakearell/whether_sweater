require 'rails_helper'

describe "Salaries Facade" do
  describe 'Happy Paths' do
    before :each do
      @salary_facade = SalariesFacade.new('denver')
    end

    it "will collect only the targeted jobs" do
      expect(@salary_facade.targeted_jobs.count).to eq(7)
      expect(@salary_facade.parse_salaries_api_call.count).to eq(7)

    end
  end
end
