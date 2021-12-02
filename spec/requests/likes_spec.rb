require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:library) { create(:library) }

  before do
    sign_in(user)
  end

  describe "#create" do
    it 'responds successfully' do
      post library_likes_path(library.id)
      expect(response).to have_http_status 302
    end

    it "save user's like successfully" do
      expect do
        post library_likes_path(library.id)
      end.to change(user.likes, :count).by(1)
    end

    it "save library's like successfully" do
      expect do
        post library_likes_path(library.id)
      end.to change(library.likes, :count).by(1)
    end

    it 'redirect to root path' do
      post library_likes_path(library.id)
      expect(response).to redirect_to root_path
    end
  end

  describe '#destroy' do
    let!(:like) { create(:like, user_id: user.id, library_id: library.id) }

    it 'responds successfully' do
      delete library_like_path(library, like.id)
      expect(response).to have_http_status 302
    end

    it "delete user's like successfully" do
      expect do
        delete library_like_path(library.id, like.id)
      end.to change(user.likes, :count).by(-1)
    end

    it "delete library's like successfully" do
      expect do
        delete library_like_path(library.id, like.id)
      end.to change(library.likes, :count).by(-1)
    end

    it 'redirect to root path' do
      delete library_like_path(library.id, like.id)
      expect(response).to redirect_to root_path
    end
  end
end
