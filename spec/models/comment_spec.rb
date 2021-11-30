require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:user) { create(:user) }
    let(:library) { create(:library) }
    let(:comment) { build(:comment, user_id: user.id, library_id: library.id) }

    it 'is valid with content' do
      expect(comment).to be_valid
    end

    it 'is invalid without content' do
      comment.content = ''
      expect(comment).not_to be_valid
    end
  end
end
