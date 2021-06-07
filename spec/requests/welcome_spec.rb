describe "Rootpath" do
  describe 'Happy Paths' do
    it "will send an message to the github endpoints" do
      get '/'
      expect(response).to be_successful
      expect(response).to be_successful
      welcome = JSON.parse(response.body, symbolize_names: true)
      expect(welcome).to be_a(Hash)
      expect(welcome).to have_key(:endpoints)
      expect(welcome[:endpoints]).to eq("https://github.com/jakejakearell/whether_sweater#readme")
    end
  end
end
