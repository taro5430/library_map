require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user, name: 'user2') }
  let!(:library) { create(:library, user_id: user1.id) }
  let!(:comment) { create(:comment, user_id: user2.id, library_id: library.id) }
  let!(:like_notification) { create(:notification, visitor_id: user2.id, visited_id: user1.id, library_id: library.id) }
  let!(:comment_notification) { create(:notification, visitor_id: user2.id, visited_id: user1.id, comment_id: comment.id, action: 'comment') }

  describe 'validation' do
    it 'like_notification valid when library_id is nil' do
      expect(comment_notification).to be_valid
    end

    it 'comment_notification valid when comment_id is nil' do
      expect(like_notification).to be_valid
    end
  end
end
