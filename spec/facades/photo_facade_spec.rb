require 'rails_helper'

describe "Photo Facade" do
  describe 'Happy Paths' do
    before :each do
      VCR.use_cassette("photo_facade_instance") do
        @photo_facade_instance = PhotoFacade.new("Denver,CO")
      end
    end

    it "parsed_down_service_call will return a Hash" do
      VCR.use_cassette("parsed_down_service_call_photo") do
        parsed = @photo_facade_instance.parsed_down_service_call
        expect(parsed).to be_a(Hash)

        expect(parsed.keys.count).to eq(6)

        expect(parsed).to have_key(:url)
        expect(parsed[:url]).to be_a(String)
        expect(parsed).to have_key(:location)
        expect(parsed[:location]).to be_a(String)
        expect(parsed).to have_key(:source)
        expect(parsed[:source]).to be_a(String)
        expect(parsed).to have_key(:photographer)
        expect(parsed[:photographer]).to be_a(String)
        expect(parsed).to have_key(:profile)
        expect(parsed[:profile]).to be_a(String)
        expect(parsed).to have_key(:title)
        expect(parsed[:title]).to be_a(String)
      end
    end

    it "photo_object will return a photo object" do
      VCR.use_cassette("photo_creation_in_facade") do
        photo_object = @photo_facade_instance.photo_object
        expect(photo_object).to be_a(Photo)
      end
    end


    it "photo_id will return a numeric string" do
      VCR.use_cassette("photo_id_facade") do
        id = @photo_facade_instance.photo_id
        expect(id).to be_a(String)
        expect(id).to eq("51139498527")
      end
    end
  end
  describe "Sad paths do" do
    xit "will return an error if an invalid location is used" do
    end

    xit "will return an empty object if there are no " do
    end
  end
end
