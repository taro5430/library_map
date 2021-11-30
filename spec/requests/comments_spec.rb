require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:library) { create(:library) }
  let!(:comment) { create(:comment, user_id: user.id, library_id: library.id) }

  describe "#index" do
    let(:library2) { create(:library) }
    let!(:comments) { create_list(:comment, 3, user_id: user.id, library_id: library2.id) }

    before do
      get library_comments_path(library2.id)
    end

    it 'responds successfully' do
      expect(response).to have_http_status 200
    end

    it 'check the variable' do
      expect(controller.instance_variable_get('@comments')).to match_array(comments)
    end
  end

  describe "#create" do
    let(:comment_params) { attributes_for(:comment, user_id: user.id, library_id: library.id) }

    before do
      sign_in(user)
    end

    it 'responds successfully' do
      post library_comments_path(library.id), params: { comment: comment_params }
      expect(response).to have_http_status 302
    end

    it 'save comment successfully' do
      expect do
        post library_comments_path(library.id), params: { comment: comment_params }
      end.to change(library.comments, :count).by(1)
      expect do
        post library_comments_path(library.id), params: { comment: comment_params }
      end.to change(user.comments, :count).by(1)
    end

    it 'redirect to library show page' do
      post library_comments_path(library.id), params: { comment: comment_params }
      expect(response).to redirect_to root_path
    end
  end

  describe 'edit' do
    before do
      sign_in(user)
      get edit_comment_path(comment.id)
    end

    it 'responds successfully' do
      expect(response).to have_http_status 200
    end

    it 'show comment content' do
      expect(response.body).to include comment.content
    end
  end

  describe 'update' do
    let(:update_comment_params) { attributes_for(:comment, :update) }
    let(:invalid_comment_params) { attributes_for(:comment, :invalid) }

    before do
      sign_in(user)
    end

    context 'valid params' do
      it 'responds successfully' do
        put comment_path(comment.id), params: { comment: update_comment_params }
        expect(response).to have_http_status 302
      end

      it 'update content successfully' do
        expect do
          put comment_path(comment.id), params: { comment: update_comment_params }
        end.to change { Comment.find(comment.id).content }.from('test comment').to('update comment')
      end

      it 'redirect to show page' do
        put comment_path(comment.id), params: { comment: update_comment_params }
        expect(response).to redirect_to :pages_profile
      end
    end

    context 'invalid params' do
      it 'responds successfully' do
        put comment_path(comment.id), params: { comment: invalid_comment_params }
        expect(response).to have_http_status 200
      end

      it 'update not successfully' do
        expect do
          put comment_path(comment.id), params: { comment: invalid_comment_params }
        end.not_to change(comment, :content)
      end

      it 'show error message' do
        put comment_path(comment.id), params: { comment: invalid_comment_params }
        expect(response.body).to include 'コメントを更新できませんでした'
      end
    end
  end

  describe '#destroy' do
    before do
      sign_in(user)
    end

    it 'responds successfully' do
      delete comment_path(comment.id)
      expect(response).to have_http_status 302
    end

    it 'delete comment' do
      expect do
        delete comment_path(comment.id)
      end.to change(user.comments, :count).by(-1)
    end

    it 'redirect to index' do
      delete comment_path(comment.id)
      expect(response).to redirect_to :pages_profile
    end
  end
end
