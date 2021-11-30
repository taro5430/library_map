require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validation' do
    it "is valid with name,email,password,password_confirmation" do
      expect(user).to be_valid
    end

    it "is not valid without name" do
      user.name = ''
      expect(user).not_to be_valid
    end

    it "is not valid without email" do
      user.email = ''
      expect(user).not_to be_valid
    end

    it "is not valid without password" do
      user.password = ''
      expect(user).not_to be_valid
    end

    it "is not valid without password_confirmation" do
      user.password_confirmation = ''
      expect(user).not_to be_valid
    end
  end

  describe 'self.guest' do
    let!(:existing_user) { create(:user) }
    let!(:guest_user) { User.guest }

    it 'create guest user when there is no guest user' do
      expect(guest_user).to be_valid
      expect(guest_user.email).to eq 'guest@example.com'
      expect(guest_user.name).to eq 'guest_user'
      expect(User.count).to eq 2
    end

    it "doesn't create guest_user when a guest user already exists" do
      guest_user2 = User.guest
      expect(User.count).to eq 2
      expect(guest_user).to eq guest_user2
    end
  end
end
