require 'rails_helper'

RSpec.describe User, type: :system do
  let!(:user) { create(:user) }
  let!(:guest_user) { create(:user, :guest) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:user_library) { create(:library, user_id: user.id) }
  let!(:admin_user_library) { create(:library, user_id: admin_user.id) }

  describe 'before login' do
    before do
      visit '/'
    end

    describe 'check header user items' do
      it 'has signup and login' do
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ゲストログイン（閲覧用）'
        expect(page).not_to have_content 'ログアウト'
        expect(page).not_to have_selector '.header-host-icon'
      end
    end

    describe 'sign up' do
      before do
        click_link '新規登録'
      end

      it 'check the sign up page' do
        expect(current_path).to eq new_user_registration_path
      end

      context 'valid information' do
        it 'registerd successfully' do
          fill_in 'ユーザー名', with: 'test_name'
          fill_in 'Eメール', with: 'test@example.com'
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq '/'
          expect(page).to have_content 'アカウント登録が完了しました'
        end
      end

      context 'invalid information' do
        it 'registerd not successfully without name' do
          fill_in 'ユーザー名', with: nil
          fill_in 'Eメール', with: 'test@example.com'
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(page).to have_content 'ユーザー名を入力してください'
        end

        it 'registerd not successfully without email address' do
          fill_in 'ユーザー名', with: 'test_name'
          fill_in 'Eメール', with: nil
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(page).to have_content 'Eメールを入力してください'
        end

        it 'registerd not successfully with duplicate email address' do
          fill_in 'ユーザー名', with: 'test_name'
          fill_in 'Eメール', with: user.email
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(page).to have_content 'Eメールはすでに存在します'
        end

        it 'registerd not successfully without password' do
          fill_in 'ユーザー名', with: 'test_name'
          fill_in 'Eメール', with: 'test@example.com'
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: nil
          fill_in 'パスワード（確認用）', with: nil
          click_button '新規登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(page).to have_content 'パスワードを入力してください'
        end

        it 'registerd not successfully when the password is not match the password_confirmation' do
          fill_in 'ユーザー名', with: 'test_name'
          fill_in 'Eメール', with: 'test@example.com'
          attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: nil
          click_button '新規登録'
          expect(current_path).to eq user_registration_path
          expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end
    end

    describe "login" do
      describe 'as a user' do
        before do
          click_link 'ログイン'
        end

        it 'check the login page' do
          expect(current_path).to eq new_user_session_path
        end

        context 'valid information' do
          it 'login sucessfully' do
            fill_in 'Eメール', with: user.email
            fill_in 'パスワード', with: user.password
            click_button 'ログイン'
            expect(page).to have_content 'ログインしました。'
          end
        end

        context 'invalid information' do
          it 'login not successfully' do
            fill_in 'Eメール', with: user.email
            fill_in 'パスワード', with: 'otherpassword'
            click_button 'ログイン'
            expect(page).to have_content 'Eメールまたはパスワードが違います。'
          end
        end
      end

      describe 'as a guest user' do
        before do
          click_link 'ゲストログイン（閲覧用）'
        end

        it 'login successfully' do
          expect(current_path).to eq '/'
          expect(page).to have_content 'ゲストユーザーとしてログインしました。'
        end
      end
    end
  end

  describe 'after login as a user' do
    before do
      login(user)
      visit '/'
    end

    describe 'check header user items' do
      it 'has icon' do
        expect(page).not_to have_content '新規登録'
        expect(page).not_to have_content 'ログイン'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_selector '.header-host-icon'
      end
    end

    describe 'profile page' do
      before do
        click_on 'アイコン画像'
      end

      it 'check the user information in the profile page' do
        expect(current_path).to eq pages_profile_path
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content user.name
        expect(page).to have_content user.email
        expect(page).to have_content 'ユーザー情報編集'
        expect(page).not_to have_content '管理者権限'
      end

      describe 'edit user' do
        before do
          click_link 'ユーザー情報編集'
        end

        it 'check the edit page' do
          expect(current_path).to eq edit_user_registration_path
        end

        context 'input valid information' do
          it 'edit user successfully' do
            fill_in 'ユーザー名', with: 'edituser'
            fill_in 'Eメール', with: 'edit@example.com'
            attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
            fill_in 'パスワード', with: 'editpassword'
            fill_in 'パスワード（確認用）', with: 'editpassword'
            fill_in '現在のパスワード', with: 'password'
            click_button '更新'
            expect(current_path).to eq '/'
            expect(page).to have_content 'アカウント情報を変更しました。'
          end
        end

        context 'input invalid information' do
          it 'edit user not successfully with wrong password' do
            fill_in 'ユーザー名', with: 'edituser'
            fill_in 'Eメール', with: 'edit@example.com'
            attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/torres1.jpeg"
            fill_in 'パスワード', with: 'editpassword'
            fill_in 'パスワード（確認用）', with: 'editpassword'
            fill_in '現在のパスワード', with: 'wrongpassword'
            click_button '更新'
            expect(page).to have_content '1件のエラーが発生したためユーザーは保存されませんでした。'
            expect(page).to have_content '現在のパスワードは不正な値です'
          end
        end

        context 'delete account' do
          it 'click the delete link' do
            page.accept_confirm do
              click_link 'アカウントを削除する'
            end
            expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
          end
        end
      end
    end

    describe 'logout' do
      it 'click the logout' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end


  describe 'after login as a guest user' do
    before do
      login(guest_user)
      visit '/'
    end

    describe 'check header user items' do
      it 'has icon' do
        expect(page).not_to have_content '新規登録'
        expect(page).not_to have_content 'ログイン'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_selector '.header-host-icon'
      end
    end

    describe 'profile page' do
      before do
        click_on 'アイコン画像'
      end

      it 'check the user information in the profile page' do
        expect(current_path).to eq pages_profile_path
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content guest_user.name
        expect(page).to have_content guest_user.email
        expect(page).to have_content '編集する'
      end

      describe 'edit user' do
        before do
          click_link '編集する'
        end

        it 'check the edit page' do
          expect(current_path).to eq edit_user_registration_path
        end

        it "can't edit user information" do
          fill_in 'Eメール', with: 'edit@example.com'
          fill_in '現在のパスワード', with: 'password'
          click_button '更新'
          expect(current_path).to eq '/'
          expect(page).to have_content 'ゲストユーザーの更新・削除はできません'
        end

        it "can't delete account" do
          page.accept_confirm do
            click_link 'アカウントを削除する'
          end
          expect(current_path).to eq '/'
          expect(page).to have_content 'ゲストユーザーの更新・削除はできません'
        end
      end
    end

    describe 'logout' do
      it 'click the logout' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end

  describe 'admin_user' do
    before do
      admin_login(admin_user)
      visit '/'
      click_on 'アイコン画像'
    end

    it 'check the user information in the profile page' do
      expect(current_path).to eq pages_profile_path
      expect(page).to have_content 'ユーザー情報'
      expect(page).to have_content admin_user.name
      expect(page).to have_content admin_user.email
      expect(page).to have_content '編集する'
      expect(page).to have_content '管理者権限'
    end

    describe 'click admin oparation' do
      before do
        click_link '管理者権限'
      end

      it 'check the admin page' do
        expect(current_path).to eq pages_admin_path
      end

      it "display all user's libraries" do
        expect(page).to have_selector "img[src$='library_image.jpg']"
        expect(page).to have_content user_library.name
        expect(page).to have_content user_library.address
        expect(page).to have_content user.name
        expect(page).to have_content admin_user_library.name
        expect(page).to have_content admin_user_library.address
        expect(page).to have_content admin_user.name
      end

      describe "can edit other user's library" do
        before do
          click_link user_library.name
        end

        it 'show admin authority button' do
          expect(current_path).to eq library_path(user_library.id)
          expect(page).to have_content '管理者権限'
          expect(page).to have_content '編集する'
          expect(page).to have_content '削除する'
        end

        it "can edit other user's library" do
          click_link '編集する'
          expect(current_path).to eq edit_library_path(user_library.id)
        end

        it "can delete other user's library" do
          page.accept_confirm do
            click_link '削除する'
          end
          expect(current_path).to eq pages_profile_path
          expect(page).to have_content '削除しました'
        end
      end
    end
  end
end
