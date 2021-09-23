require 'rails_helper'

RSpec.describe "Googlemaps", type: :system do
  describe 'googlemap function' do
    let!(:tokyo_library) { create(:library, address: '東京都港区芝公園４丁目２−８') }
    let!(:chiba_library) { create(:library, address: '千葉県浦安市舞浜１−１') }
    
    it 'check googole map api', js: true do 
      visit pages_home_path
      expect(page).to have_selector '#gmimap0 area'
      expect(page).to have_selector '#gmimap1 area'
      find('#gmimap0 area', visible: false).click
      expect(page).to have_content tokyo_library.name
      click_link tokyo_library.name
      expect(current_path).to eq library_path(tokyo_library.id)
      expect(page).to have_selector '#gmimap0 area'
    end
  end
end
