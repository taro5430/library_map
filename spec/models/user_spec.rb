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
end
