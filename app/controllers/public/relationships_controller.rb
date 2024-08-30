class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    user = User.find(params[:user_id])
    if current_user.follow(user)
      flash[:notice] = "フォローしました。"
    else
      flash[:alert] = "フォローできませんでした。"
    end
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    if current_user.unfollow(user)
      flash[:notice] = "フォローを解除しました。"
    else
      flash[:alert] = "フォロー解除できませんでした。"
    end
    redirect_to  request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
