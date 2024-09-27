class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = current_user.likes.all
  end

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    if like.save
      flash[:notice] = "いいねに成功しました。"
    else
      flash[:alert] = "いいねに失敗しました。"
    end
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    if like.destroy
      flash[:notice] = "いいねを取り消しました。"
    else
      flash[:alert] = "いいねをの取り消しに失敗しました。"
    end
    redirect_to post_path(post)
  end
end
