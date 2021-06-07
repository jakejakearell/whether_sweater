require 'rails_helper'

RSpec.describe Photo do
  describe 'happy path' do
    it 'has expected attributes' do
      VCR.use_cassette("photo_poro") do
        result = PhotoFacade.new("mead,co").photo_object

        expect(result).to be_a(Photo)
        expect(result.id).to eq("null")
        expect(result.url).to eq("https://www.flickr.com/photos/thelightningman/51171643872/")
        expect(result.location).to eq("Colorado, Kirkland")
        expect(result.source).to eq("flickr.com")
        expect(result.photographer).to eq("Striking Photography by Bo Insogna")
        expect(result.profile).to eq("https://www.flickr.com/photos/48896557@N00")
        expect(result.title).to eq("Colorado Rocky Mountain Front Range Panoramic")

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
