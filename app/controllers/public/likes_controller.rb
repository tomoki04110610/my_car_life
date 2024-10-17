class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = current_user.likes.all
  end

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)

    if like.save
      flash.now[:notice] = "いいねに成功しました。"
      @post = post
    else
      flash.now[:alert] = "いいねに失敗しました。"
    end

    respond_to do |format|
      format.html { redirect_to post_path(post) }
      format.js { render 'replace_flash_and_btn'}
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)

    unless like
      respond_to do |format|
        format.html { redirect_to post_path(post) }
        format.js { render 'replace_flash_and_btn'}
      end
      return
    end

    if like.destroy
      flash.now[:notice] = "いいねを取り消しました。"
      @post = post
    else
      flash.now[:alert] = "いいねをの取り消しに失敗しました。"
    end

    respond_to do |format|
      format.html { redirect_to post_path(post) }
      format.js { render 'replace_flash_and_btn'}
    end
  end
end
