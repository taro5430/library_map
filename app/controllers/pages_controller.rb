class PagesController < ApplicationController
  def home
    @libraries = Library.all
  end
  
  def profile
    @libraries = current_user.libraries.all
  end
end
