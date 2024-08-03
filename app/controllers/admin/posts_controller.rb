class Admin::PostsController < ApplicationController
  layout 'admin'

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.post_comments.all
  end
end
