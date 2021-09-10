class LibrariesController < ApplicationController
  def index
    @libraries = current_user.libraries.all
  end
  
  def display
    @libraries = Library.all
  end

  def new
    @library = Library.new
  end

  def create
    @library = current_user.libraries.new(library_params)
    if @library.save
      flash[:success] = "登録しました"
      redirect_to @library
    else
      flash[:danger] = "登録できませんでした"
      render "new"
    end
  end

  def show 
    @library = Library.find(params[:id])
    @user = User.find_by(id: @library.user_id)
  end

  def edit
    @library = Library.find(params[:id])
  end

  def update
    @library = Library.find(params[:id])
    if @library.update(library_params)
      flash[:success] = "更新しました"
      redirect_to @library
    else
      render "edit"
    end
  end

  def destroy
    @library = Library.find(params[:id])
    @library.destroy
    flash[:danger] = "削除しました"
    redirect_to :libraries
  end

  private

  def library_params
    params.require(:library).permit(:name, :address, :access, :study_space, :electrical_outlet, :image, :detail)
  end

end
