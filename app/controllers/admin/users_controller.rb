class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

# ソフトデリート
  def destroy
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_dashboards_path, notice: 'ユーザーを無効化しました。'
  end

  # 完全削除
  def delete_permanently
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを完全に削除しました。'
  end
end
