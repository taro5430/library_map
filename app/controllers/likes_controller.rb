class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(library_id: params[:library_id])
    flash[:success] = "いいねしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(library_id: params[:library_id], user_id: current_user.id)
    @like.destroy
    flash[:danger] = "いいねを取り消しました"
    redirect_back(fallback_location: root_path)
  end
end
