require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:library) { create(:library, user_id: user1.id) }
  let!(:comment) { create(:comment, user_id: user2.id, library_id: library.id) }
  let!(:like_notification) { create(:notification, visitor_id: user2.id, visited_id: user1.id, library_id: library.id) }
  let!(:comment_notification) { create(:notification, visitor_id: user2.id, visited_id: user1.id, library_id: comment.library_id, comment_id: comment.id, action: 'comment') }

  before do
    sign_in(user1)
  end

  describe "#index" do
    it 'responds successfully' do
      get notifications_path
      expect(response).to have_http_status 200
    end

    it 'check variable that order desc' do
      get notifications_path
      expect(controller.instance_variable_get('@notifications')).to match [Notification.second, Notification.first]
    end

    it 'change checked state' do
      expect(Notification.first.checked).to be false
      expect(Notification.second.checked).to be false
      get notifications_path
      expect(Notification.first.checked).to be true
      expect(Notification.second.checked).to be true
    end
  end

  describe '#destroy_all' do
    it 'responds successfully' do
      delete destroy_all_notifications_path
      expect(response).to have_http_status 302
    end

    it 'delete all notifications' do
      expect do
        delete destroy_all_notifications_path
      end.to change(user1.passive_notifications, :count).by(-2)
    end
  end
end
