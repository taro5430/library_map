require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:guest_user) { create(:user, :guest) }

  describe 'registration #new' do
    it 'responds successfully' do
      get new_user_registration_path
      expect(response).to have_http_status 200
    end
  end

  describe 'registration #edit' do
    before do
      sign_in(user)
      get edit_user_registration_path(user.id)
    end

    it 'responds successfully' do
      expect(response).to have_http_status 200
    end

    it 'show user name' do
      expect(response.body).to include user.name
    end

    it 'show email address' do
      expect(response.body).to include user.email
    end
  end

  describe 'registration #create' do
    let(:user_params) { attributes_for(:user) }
    let(:invalid_user_params) { attributes_for(:user, :invalid) }

    context 'valid params' do
      it 'responds successfully' do
        post user_registration_path, params: { user: user_params }
        expect(response).to have_http_status 302
      end

      it 'create user successfully' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)
      end

      it 'redirect to root' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'invalid params' do
      it 'responds successfully' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response).to have_http_status 200
      end

      it 'create user not successfully' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end

      it 'show error message' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include '1件のエラーが発生したためユーザーは保存されませんでした。'
        expect(response.body).to include 'ユーザー名を入力してください'
      end
    end
  end

  describe 'registration #update' do
    let(:update_params) { { name: "updateuser", current_password: user.password } }
    let(:invalid_update_params) { { name: nil, current_password: user.password } }

    describe 'login as a user' do
      before do
        sign_in(user)
      end

      context 'valid params' do
        it 'responds successfully' do
          put user_registration_path, params: { user: update_params }
          expect(response).to have_http_status 302
        end

        it 'update user information' do
          expect do
            put user_registration_path, params: { user: update_params }
          end.to change { User.find(user.id).name }.from('testuser').to('updateuser')
        end

        it 'redirect to root' do
          put user_registration_path, params: { user: update_params }
          expect(response).to redirect_to root_path
        end
      end

      context 'invalid params' do
        it 'responds successfully' do
          put user_registration_path, params: { user: invalid_update_params }
          expect(response).to have_http_status 200
        end

        it 'update user information not successfully' do
          expect do
            put user_registration_path, params: { user: invalid_update_params }
          end.not_to change(User.find(user.id), :name)
        end

        it 'show errow message' do
          put user_registration_path, params: { user: invalid_update_params }
          expect(response.body).to include '1件のエラーが発生したためユーザーは保存されませんでした。'
          expect(response.body).to include 'ユーザー名を入力してください'
        end
      end
    end

    describe 'login as a guest user' do
      before do
        sign_in(guest_user)
      end

      it 'responds successfully' do
        put user_registration_path, params: { user: update_params }
        expect(response).to have_http_status 302
        put user_registration_path, params: { user: invalid_update_params }
        expect(response).to have_http_status 302
      end

      it "can't update user information even with valid params" do
        expect do
          put user_registration_path, params: { user: update_params }
        end.not_to change(User.find(guest_user.id), :name)
      end

      it 'redirect to root' do
        put user_registration_path, params: { user: update_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'registration #destroy' do
    describe 'login as a user' do
      before do
        sign_in(user)
      end

      it 'responds successfully' do
        delete user_registration_path
        expect(response).to have_http_status 302
      end

      it 'delete user' do
        expect do
          delete user_registration_path
        end.to change(User, :count).by(-1)
      end

      it 'redirect to' do
        delete user_registration_path
        expect(response).to redirect_to root_path
      end
    end

    describe 'login as a guest user' do
      before do
        sign_in(guest_user)
      end

      it 'responds successfully' do
        delete user_registration_path
        expect(response).to have_http_status 302
      end

      it 'delete user' do
        expect do
          delete user_registration_path
        end.not_to change(User, :count)
      end

      it 'redirect to' do
        delete user_registration_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'session #new' do
    it 'responds successfully' do
      get new_user_session_path
      expect(response).to have_http_status 200
    end
  end

  describe 'session #create' do
    let(:login_params) { { email: user.email, password: user.password } }
    let(:invalid_login_params) { { email: user.email, password: "invalidpassword" } }

    context 'valid params' do
      before do
        post user_session_path, params: { user: login_params }
      end

      it 'responds successfully' do
        expect(response).to have_http_status 302
      end

      it 'redirect to root' do
        expect(response).to redirect_to root_path
      end
    end

    context 'invalid params' do
      before do
        post user_session_path, params: { user: invalid_login_params }
      end

      it 'responds successfully' do
        expect(response).to have_http_status 200
      end

      it 'show error message' do
        expect(response.body).to include 'Eメールまたはパスワードが違います。'
      end
    end
  end

  describe 'session #destroy' do
    before do
      sign_in(user)
      delete destroy_user_session_path
    end

    it 'responds successfully' do
      expect(response).to have_http_status 302
    end

    it 'logout successfully' do
      expect(response).to redirect_to root_path
    end
  end

  describe 'session #guest_sign_in' do
    it 'responds successfully' do
      post users_guest_sign_in_path
      expect(response).to have_http_status 302
    end
  end
end
