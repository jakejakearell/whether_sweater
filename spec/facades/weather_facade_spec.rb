require 'rails_helper'

describe "Weather Facade" do
  describe 'Happy Paths' do
    it "" do
      VCR.use_cassette("weather_facade_denver") do
      end
    end
  end
end
