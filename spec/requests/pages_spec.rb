require 'rails_helper'

RSpec.describe "Pages", type: :request do
  let!(:library) { create(:library) }
  let(:user) { create(:user) }

  describe "GET /pages/home" do
    before do
      get pages_home_path
    end

    it "responds successfully" do
      expect(response).to have_http_status 200
    end
  end

  describe "GET /pages/introduction" do
    it "responds successfully" do
      get pages_introduction_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /pages/profile" do
    before do
      sign_in(user)
    end

    it "responds successfully" do
      get pages_profile_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /pages/admin" do
    let(:admin_user) { create(:user, :admin) }
    
    before do
      sign_in(admin_user)
    end

    it "responds successfully" do
      get pages_admin_path
      expect(response).to have_http_status 200
    end
  end
end
