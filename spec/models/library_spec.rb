require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'validation' do
    let(:library) { build(:library) }

    it "is valid with name,address,access,study_space,electrical_outlet" do
      expect(library).to be_valid
    end

    it "is not valid without name" do
      library.name = ''
      expect(library).not_to be_valid
    end

    it "is not valid without address" do
      library.address = ''
      expect(library).not_to be_valid
    end

    it "is not valid without access" do
      library.access = ''
      expect(library).not_to be_valid
    end

    it "is not valid without study_space" do
      library.study_space = ''
      expect(library).not_to be_valid
    end

    it "is not valid without electrical_outlet" do
      library.electrical_outlet = ''
      expect(library).not_to be_valid
    end
  end

  describe 'geocoder' do
    let!(:library) { create(:library, address: '東京都港区芝公園４丁目２−８') }

    it 'get latitude and longitude' do
      expect(library.latitude).not_to be_nil
      expect(library.longitude).not_to be_nil
    end
  end

  describe "search libraries that match keyword" do
    let!(:library1) { create(:library, name: '神奈川図書館') }
    let!(:library2) { create(:library, address: '横浜市') }
    let!(:library3) { create(:library, access: 'みなとみらい駅') }
    let!(:library4) { create(:library, detail: '静かです') }

    context "when it is match with keyword" do
      it "display libraries that include name keyword" do
        expect(Library.search('神奈川')).to include library1
        expect(Library.search('神奈川')).not_to include(library2, library3, library4)
      end

      it "display libraries that include address keyword" do
        expect(Library.search('横浜')).to include library2
        expect(Library.search('横浜')).not_to include(library1, library3, library4)
      end

      it "display libraries that include access keyword" do
        expect(Library.search('みなとみらい')).to include library3
        expect(Library.search('みなとみらい')).not_to include(library1, library2, library4)
      end

      it "display libraries that include detail keyword" do
        expect(Library.search('静か')).to include library4
        expect(Library.search('静か')).not_to include(library1, library2, library3)
      end
    end

    context "when it is not match with keyword" do
      it "display no library that include keyword" do
        expect(Library.search('アメリカ')).to be_empty
      end
    end
  end
end
