require 'rails_helper'

RSpec.describe "Libraries", type: :request do
  let!(:user) { create(:user) }

  describe '#index' do
    let!(:libraries) { create_list(:library, 3) }

    before do
      get libraries_path
    end

    it 'responds successfully' do
      expect(response).to have_http_status 200
    end

    it 'check the variable' do
      expect(controller.instance_variable_get('@libraries')).to match_array(libraries)
    end
  end

  describe '#new' do
    before do
      sign_in(user)
    end

    it "responds successfully" do
      get new_library_path
      expect(response).to have_http_status 200
    end
  end

  describe '#create' do
    let(:library_params) { attributes_for(:library) }
    let(:invalid_library_params) { attributes_for(:library, :invalid) }

    before do
      sign_in(user)
    end

    context 'valid params' do
      it 'responds successfully' do
        post libraries_path, params: { library: library_params }
        expect(response).to have_http_status 302
      end

      it 'save library sucessfully' do
        expect do
          post libraries_path, params: { library: library_params }
        end.to change(user.libraries, :count).by(1)
      end

      it 'redirect to show page' do
        post libraries_path, params: { library: library_params }
        expect(response).to redirect_to library_path(Library.first.id)
      end
    end

    context 'invalid params' do
      it 'responds successfully' do
        post libraries_path, params: { library: invalid_library_params }
        expect(response).to have_http_status 200
      end

      it 'save library not sucessfully' do
        expect do
          post libraries_path, params: { library: invalid_library_params }
        end.not_to change(user.libraries, :count)
      end

      it 'show error message' do
        post libraries_path, params: { library: invalid_library_params }
        expect(response.body).to include '登録できませんでした'
      end
    end
  end

  describe '#show' do
    let(:library) { create(:library) }

    before do
      get library_path(library.id)
    end

    it "responds successfully" do
      expect(response).to have_http_status 200
    end

    it 'check the variable' do
      expect(controller.instance_variable_get('@library')).to eq library
    end
  end

  describe '#edit' do
    let(:library) { create(:library, user_id: user.id) }

    before do
      sign_in(user)
      get edit_library_path(library.id)
    end

    it 'responds successfully' do
      expect(response).to have_http_status 200
    end

    it 'show library information' do
      expect(response.body).to include library.name
      expect(response.body).to include library.address
      expect(response.body).to include library.access
      expect(response.body).to include library.study_space
      expect(response.body).to include library.electrical_outlet
      expect(response.body).to include library.detail
    end
  end

  describe '#update' do
    let!(:library) { create(:library, user_id: user.id) }
    let(:update_library_params) { attributes_for(:library, :update) }
    let(:invalid_library_params) { attributes_for(:library, :invalid) }

    before do
      sign_in(user)
    end

    context 'valid params' do
      it 'responds successfully' do
        put library_path(library.id), params: { library: update_library_params }
        expect(response).to have_http_status 302
      end

      it 'update detail successfully' do
        expect do
          put library_path(library.id), params: { library: update_library_params }
        end.to change { Library.find(library.id).detail }.from('testdetail').to('updatedetail')
      end

      it 'redirect to show page' do
        put library_path(library.id), params: { library: update_library_params }
        expect(response).to redirect_to library
      end
    end

    context 'invalid params' do
      it 'responds successfully' do
        put library_path(library.id), params: { library: invalid_library_params }
        expect(response).to have_http_status 200
      end

      it 'update not successfully' do
        expect do
          put library_path(library.id), params: { library: invalid_library_params }
        end.not_to change(Library.find(library.id), :name)
      end

      it 'show error message' do
        put library_path(library.id), params: { library: invalid_library_params }
        expect(response.body).to include '更新できませんでした'
      end
    end
  end

  describe '#destroy' do
    let!(:library) { create(:library, user_id: user.id) }

    before do
      sign_in(user)
    end

    it 'responds successfully' do
      delete library_path(library.id)
      expect(response).to have_http_status 302
    end

    it 'delete libarary' do
      expect do
        delete library_path(library.id)
      end.to change(user.libraries, :count).by(-1)
    end

    it 'redirect to index' do
      delete library_path(library.id)
      expect(response).to redirect_to pages_profile_path
    end
  end
end
