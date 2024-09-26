class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました。"
  end
end
