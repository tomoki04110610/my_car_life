class UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where.not(email: User::GUEST_USER_EMAIL)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "ユーザー登録情報の更新に成功しました。"
      redirect_to mypage_path(user.id)
    else
      flash.now[:alert] = "ユーザー登録情報の更新に失敗しました。"
      @user = User.find(params[:id])
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.update(is_active: false)
    sign_out
    flash[:notice] = "退会処理に成功しました。"
    redirect_to new_user_registration_path
  end


  def mypage
    @user = current_user
    @driving_distance = DrivingDistance.new
    @post = Post.new
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path, alert: "他のユーザーの登録情報は編集できません"
    end
  end

end
