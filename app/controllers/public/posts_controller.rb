class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @post = current_user.posts.new(post_params)
    if @post.genre_id == 1
      driving_distance = DrivingDistance.where(car_model_id: @post.car_model_id).order(created_at: :desc).first
      @post.distance = driving_distance.distance if driving_distance.present?
    end
    
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      @user = current_user
      @driving_distance = DrivingDistance.new
      render :"public/users/mypage"
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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
    params.require(:post).permit(:title, :body, :genre_id, :post_image, :notification_id, :car_model_id, :distance)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      redirect_to posts_path, alert: "他のユーザーの投稿は編集できません"
    end
  end

end
