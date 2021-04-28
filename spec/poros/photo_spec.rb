require 'rails_helper'

RSpec.describe Photo do
  describe 'happy path' do
    it 'has expected attributes' do
      VCR.use_cassette("photo_poro") do
        result = PhotoFacade.new("mead,co").photo_object

        expect(result).to be_a(Photo)
        expect(result.id).to eq("null")
        expect(result.url).to eq("https://www.flickr.com/photos/john_crisanti_photography/51086607992/")
        expect(result.location).to eq("Colorado, Highland")
        expect(result.source).to eq("flickr.com")
        expect(result.photographer).to eq("Colorado & Southern")
        expect(result.profile).to eq("https://www.flickr.com/photos/61254866@N07")
        expect(result.title).to eq("Still Going Strong")

      end
    end
  end

  describe 'sad path' do
    it 'will still make a poro without an argument' do
      VCR.use_cassette("photo_poro_sad") do
        result = Photo.new()

        expect(result).to be_a(Photo)
        expect(result.id).to eq("null")
        expect(result.url).to eq(nil)
        expect(result.location).to eq(nil)
        expect(result.source).to eq(nil)
        expect(result.photographer).to eq(nil)
        expect(result.profile).to eq(nil)
        expect(result.title).to eq(nil)

      end
    end
  end
end
