class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      @user = current_user
      @driving_distance = DrivingDistance.new
      @post = Post.new
      render :"users/mypage"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の更新に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿の更新に失敗しました。"
      @post = Post.find(params[:id])
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿の削除に成功しました。"
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :post_image)
  end

end
