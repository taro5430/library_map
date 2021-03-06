class PagesController < ApplicationController
  def home
    @libraries = Library.all
  end

  def profile
    @libraries = current_user.libraries.all
    @comments = current_user.comments.all
    @likes = current_user.likes.all
  end

  def admin
    @user = User.all
    @libraries = Library.all
  end
end
