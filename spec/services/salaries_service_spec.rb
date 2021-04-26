require 'rails_helper'

RSpec.describe 'Salaries Service' do
  describe 'Happy Paths' do

    it 'will establish a connection to the salaries service' do

      service = SalariesService.salaries('denver')

      expect(service).to be_a(Hash)
      expect(service).to have_key(:results)


    end
  end
end
