class UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "ユーザー登録情報の更新に成功しました。"
      redirect_to user_path(user.id)
    else
      flash.now[:notice] = "ユーザー登録情報の更新に失敗しました。"
      @user = User.find(params[:id])
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.update(is_active: false)
    flash[:notice] = "退会処理に成功しました。"
    redirect_to new_user_session_path
  end


  def mypage
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
