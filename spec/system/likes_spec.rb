require 'rails_helper'

RSpec.describe "Likes", type: :system do
  let!(:user) { create(:user) }
  let!(:library) { create(:library) }

  describe 'not login user' do
    before do
      visit '/'
      click_link '図書館一覧'
      click_link library.name
    end

    it 'check like items' do
      expect(page).not_to have_content 'いいね！'
      expect(page).not_to have_selector '.like-btn'
      expect(page).to have_selector '.like-icon', visible: true
      expect(page).to have_selector '.like-count', text: '0'
    end
  end

  describe 'login user' do
    before do
      login(user)
      visit '/'
      click_link '図書館一覧'
      click_link library.name
    end

    it 'check like items' do
      expect(page).to have_content 'いいね！'
      expect(page).to have_selector '.like-btn'
      expect(page).not_to have_selector '.unlike-btn'
      expect(page).to have_selector '.like-icon', visible: true
      expect(page).to have_selector '.like-count', text: '0'
      click_link 'アイコン画像'
      expect(page).to have_content 'いいねした図書館'
      expect(page).to have_selector '.like-icon'
      expect(page).to have_content 'いいねした図書館はありません'
    end

    it 'click like button' do
      find(:css, '.like-link').click
      expect(page).not_to have_selector '.like-btn'
      expect(page).to have_selector '.unlike-btn'
      expect(page).to have_selector '.like-count', text: '1'
      click_link 'アイコン画像'
      expect(page).to have_content 'いいねした図書館'
      expect(page).to have_selector '.like-icon'
      expect(page).to have_content '図書館名'
      expect(page).to have_content '住所'
      expect(page).to have_content 'アクセス'
      expect(page).to have_content '勉強スペース'
      expect(page).to have_content 'コンセントの有無'
      expect(page).to have_content library.name
      expect(page).to have_content library.address
      expect(page).to have_content library.access
      expect(page).to have_content library.study_space
      expect(page).to have_content library.electrical_outlet
      click_link library.name
      expect(current_path).to eq library_path(library.id)
    end
  end
end
