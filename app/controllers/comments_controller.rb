class CommentsController < ApplicationController
  def index
    @library = Library.find(params[:library_id])
    @comments = @library.comments
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @library = @comment.library
    if @comment.save
      @library.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントを登録しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントを登録できませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "コメントを更新しました"
      redirect_to :pages_profile
    else
      flash[:danger] = "コメントを更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:danger] = "コメントを削除しました"
    redirect_to :pages_profile
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :library_id)
  end
end
