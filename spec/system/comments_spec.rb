require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user, name: 'user2') }
  let!(:library1) { create(:library) }
  let!(:library2) { create(:library, name: 'library2') }
  let!(:comment1) { create(:comment, user_id: user1.id, library_id: library1.id) }
  let!(:comment2) { create(:comment, content: 'comment2', user_id: user2.id, library_id: library2.id) }

  describe 'create comment' do
    describe 'login user' do
      before do
        login(user1)
        visit '/'
        click_link '図書館一覧'
        click_link library1.name
      end

      it 'show comment items' do
        expect(page).to have_selector '.comment-icon', visible: true
        expect(page).to have_content 'コメントをしよう！'
      end

      it 'can create comment' do
        fill_in 'comment[content]', with: 'create comment'
        click_button '投稿'
        expect(page).to have_content 'コメントを登録しました'
        find(:css, '.comment-link').click
        expect(current_path).to eq library_comments_path(library1.id)
        expect(page).to have_content 'コメント一覧'
        expect(page).to have_selector '.comment-icon', visible: true
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content 'コメント'
        expect(page).to have_content user1.name, count: 2
        expect(page).to have_content comment1.content
        expect(page).to have_content 'create comment'
        expect(page).not_to have_content user2.name
        expect(page).not_to have_content comment2.content
      end
    end

    describe 'not login user' do
      before do
        visit '/'
        click_link '図書館一覧'
        click_link library1.name
      end

      it "doesn't show comment area" do
        expect(page).to have_selector '.comment-icon'
        expect(page).not_to have_content 'コメントをしよう！'
        find(:css, '.comment-link').click
        expect(current_path).to eq library_comments_path(library1.id)
        expect(page).to have_content 'コメント一覧'
        expect(page).to have_selector '.comment-icon', visible: true
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content 'コメント'
        expect(page).to have_content user1.name, count: 1
        expect(page).to have_content comment1.content
        expect(page).not_to have_content user2.name
        expect(page).not_to have_content comment2.content
        expect(page).not_to have_content 'create comment'
      end
    end
  end

  describe 'check my comment' do
    before do
      login(user1)
      visit '/'
      click_on 'アイコン画像'
    end

    it "show login_user's comment" do
      expect(page).to have_content 'コメント一覧'
      expect(page).to have_selector '.comment-icon', visible: true
      expect(page).to have_content '図書館名'
      expect(page).to have_link library1.name
      expect(page).not_to have_link library2.name
      expect(page).to have_content 'コメント'
      expect(page).to have_content comment1.content
      expect(page).not_to have_content comment2.content
      expect(page).to have_link '編集'
      expect(page).to have_link '削除'
    end

    describe 'edit comment' do
      before do
        click_link '編集'
      end

      it 'check comment edit page' do
        expect(current_path).to eq edit_comment_path(comment1.id)
        expect(page).to have_content 'コメント編集'
        expect(page).to have_content "図書館名：#{library1.name}"
        expect(page).to have_content 'コメント'
        expect(page).to have_field 'コメント', with: comment1.content
      end

      it 'can edit comment' do
        fill_in 'コメント', with: 'update content'
        click_button '編集完了'
        expect(current_path).to eq pages_profile_path
        expect(page).to have_content 'コメントを更新しました'
        expect(page).to have_content 'update content'
        expect(page).not_to have_content comment1.content
      end

      it "can't edit comment with no content" do
        fill_in 'コメント', with: ''
        click_button '編集完了'
        expect(current_path).to eq comment_path(comment1.id)
        expect(page).to have_content 'コメントを更新できませんでした'
        expect(page).to have_content 'コメントを入力してください'
      end
    end

    describe 'delete comment' do
      it 'can delete comment' do
        page.accept_confirm do
          click_link '削除'
        end
        expect(page).to have_content 'コメントを削除しました'
        expect(page).to have_content 'コメントはありません'
        expect(page).not_to have_content comment1.content
      end
    end
  end
end
