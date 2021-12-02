require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { create(:user) }
  let!(:library) { create(:library) }
  let!(:like) { create(:like, user_id: user.id, library_id: library.id) }

  describe 'validation' do
    it 'valid' do
      expect(like).to be_valid
    end
  end

  describe 'uniqueness of library and user' do
    let(:like2) { build(:like, user_id: user.id, library_id: library.id) }

    it "can't create like with same libarary and user" do
      expect(like2).not_to be_valid
    end
  end
end
