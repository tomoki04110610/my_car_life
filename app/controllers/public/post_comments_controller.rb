class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "コメントを投稿しました。"
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
    end
    redirect_to request.referer
  end

  def destroy
    comment = PostComment.find(params[:id])
    if comment.destroy
      flash[:notice] = "コメントを削除しました。"
    else
      flash[:alert] = "コメントの削除に失敗しました。"
    end
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def correct_user
    comment = PostComment.find(params[:id])
    unless comment.user_id == current_user.id
      redirect_to mypage_path, alert: "他のユーザーのコメントは削除できません"
    end
  end
end
