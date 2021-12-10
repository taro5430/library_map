require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user, name: 'user2') }
  let!(:library) { create(:library, user_id: user1.id) }

  describe 'create notification' do
    before do
      login(user2)
      visit '/'
      click_link '図書館一覧'
      click_link library.name
      find(:css, '.like-link').click
      fill_in 'comment[content]', with: 'create comment'
      click_button '投稿'
      click_link 'ログアウト'
      login(user1)
      visit '/'
    end

    it 'check notification mark' do
      expect(page).to have_selector '.notification-mark', visible: true
    end

    it 'check notification page' do
      find(:css, '.btn-default').click
      expect(current_path).to eq notifications_path
      expect(page).not_to have_selector '.notication-mark'
      expect(page).to have_content '通知一覧'
      expect(page).to have_selector '.fa-trash', visible: true
      expect(page).to have_link '全削除'
      expect(page).to have_selector "img[src$='torres1.jpeg']"
      expect(page).to have_content "#{user2.name}さんが あなたの登録した#{library.name}にコメントしました。"
      expect(page).to have_content "(#{time_ago_in_words(Notification.first.created_at).upcase}前)"
      expect(page).to have_content 'create comment'
      expect(page).to have_content "#{user2.name}さんが あなたの登録した#{library.name}にいいねしました。"
      expect(page).to have_content "(#{time_ago_in_words(Notification.second.created_at).upcase}前)"
      click_link 'Library map for study'
      expect(page).not_to have_selector '.notication-mark'
    end
  end
end
