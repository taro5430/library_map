class PagesController < ApplicationController
  def home
    @libraries = Library.all
  end

  def profile
    @libraries = current_user.libraries.all
  end

  def admin
    @user = User.all
    @libraries = Library.all
  end
end
