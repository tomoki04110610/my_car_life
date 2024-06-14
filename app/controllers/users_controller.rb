class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
  end

  def mypage
    @user = current_user
  end
end
