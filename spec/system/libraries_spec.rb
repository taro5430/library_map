require 'rails_helper'

RSpec.describe "Libraries", type: :system do
  let!(:userA) { create(:user) }
  let!(:libraryA) { create(:library, user_id: userA.id) }
  let!(:userB) { create(:user) }
  let!(:libraryB) { create(:library, user_id: userB.id) }

  describe 'before login' do
    describe 'check header library items' do
      before do
        visit '/'
      end

      it 'has library index' do
        expect(page).to have_content '図書館一覧'
        expect(page).not_to have_content '図書館登録'
      end
    end
  end

  describe 'after login' do
    before do
      login(userA)
      visit '/'
    end

    describe 'check header library items' do
      it 'has library index and register library' do
        expect(page).to have_content '図書館登録'
        expect(page).to have_content '図書館一覧'
      end
    end

    describe 'register library' do
      before do
        click_link '図書館登録'
      end

      it 'check the register page' do
        expect(current_path).to eq new_library_path
      end

      context 'input valid information' do
        it 'register library successfully' do
          fill_in '図書館名', with: 'new library'
          fill_in '住所', with: 'new address'
          fill_in 'アクセス', with: 'new access'
          select '50席以上', from: '勉強スペース'
          select 'あり', from: 'コンセントの有無'
          attach_file '写真', "#{Rails.root}/spec/fixtures/library_image.jpg"
          fill_in '詳細コメント', with: 'new coment'
          click_button '登録'
          expect(page).to have_selector "img[src$='library_image.jpg']"
          expect(page).to have_content 'new library'
          expect(page).to have_content 'new address'
          expect(page).to have_content 'new access'
          expect(page).to have_content '50席以上'
          expect(page).to have_content 'あり'
          expect(page).to have_content 'new coment'
          expect(page).to have_selector "img[src$='torres1.jpeg']"
          expect(page).to have_content userA.name
        end
      end

      context 'input invalid information' do
        it 'register library not successfully' do
          fill_in '図書館名', with: nil
          fill_in '住所', with: nil
          fill_in 'アクセス', with: nil
          fill_in '詳細コメント', with: nil
          click_button '登録'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content '名前を入力してください'
          expect(page).to have_content '住所を入力してください'
          expect(page).to have_content 'アクセスを入力してください'
          expect(page).to have_content '勉強スペースを入力してください'
          expect(page).to have_content 'コンセントの有無を入力してください'
        end
      end
    end

    describe 'libraries index' do
      before do
        click_link '図書館一覧'
      end

      it 'check the index page' do
        expect(current_path).to eq libraries_path
        expect(page).to have_selector "img[src$='library_image.jpg']"
        expect(page).to have_content libraryA.name
        expect(page).to have_content libraryA.address
        expect(page).not_to have_content libraryA.access
        expect(page).not_to have_content libraryA.study_space
        expect(page).not_to have_content libraryA.electrical_outlet
        expect(page).not_to have_content libraryA.detail
        expect(page).to have_content libraryB.name
        expect(page).to have_content libraryB.address
        expect(page).not_to have_content libraryB.access
        expect(page).not_to have_content libraryB.study_space
        expect(page).not_to have_content libraryB.electrical_outlet
        expect(page).not_to have_content libraryB.detail
      end

      it 'click the library' do
        click_link libraryA.name
        expect(current_path).to eq library_path(libraryA.id)
        expect(page).to have_selector "img[src$='library_image.jpg']"
        expect(page).to have_content libraryA.name
        expect(page).to have_content libraryA.address
        expect(page).to have_content libraryA.access
        expect(page).to have_content libraryA.study_space
        expect(page).to have_content libraryA.electrical_outlet
        expect(page).to have_content libraryA.detail
        expect(page).to have_selector "img[src$='torres1.jpeg']"
        expect(page).to have_content userA.name
      end
    end

    describe 'edit or delete libraries' do
      before do
        click_on 'アイコン画像'
      end

      it 'check the library information in the profile page' do
        expect(current_path).to eq pages_profile_path
        expect(page).to have_selector "img[src$='library_image.jpg']"
        expect(page).to have_content libraryA.name
        expect(page).to have_content libraryA.address
        expect(page).not_to have_content libraryB.name
        expect(page).not_to have_content libraryB.address
      end

      it 'click the library information' do
        click_on libraryA.name
        expect(current_path).to eq library_path(libraryA.id)
      end
      
      it 'click the edit link' do
        find('.edit-link').click
        expect(current_path).to eq edit_library_path(libraryA.id)
        fill_in '図書館名', with: 'edit library'
        fill_in '住所', with: 'edit address'
        fill_in 'アクセス', with: 'edit access'
        select '20席以上', from: '勉強スペース'
        select 'なし', from: 'コンセントの有無'
        attach_file '写真', "#{Rails.root}/spec/fixtures/edit_library_image.jpg"
        fill_in '詳細コメント', with: 'edit coment'
        click_button '編集完了'
        expect(current_path).to eq library_path(libraryA.id)
        expect(page).to have_content '更新しました'
        expect(page).to have_selector "img[src$='edit_library_image.jpg']"
        expect(page).to have_content 'edit library'
        expect(page).to have_content 'edit address'
        expect(page).to have_content 'edit access'
        expect(page).to have_content '20席以上'
        expect(page).to have_content 'なし'
        expect(page).to have_content 'edit coment'
      end

      it 'click the delete link' do
        page.accept_confirm do
          click_link '削除する'
        end
        expect(current_path).to eq pages_profile_path
        expect(page).to have_content '削除しました'
        expect(page).not_to have_selector "img[src$='library_image.jpg']"
        expect(page).not_to have_content libraryA.name
        expect(page).not_to have_content libraryA.address
      end
    end
  end
end
