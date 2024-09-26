class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  # ソフトデリート（無効）
  def destroy
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_dashboards_path, notice: 'ユーザーを無効にしました。'
  end

  # ユーザー復元（有効）
  def restore
    @user = User.find(params[:id])
    @user.update(is_active: true)
    redirect_to admin_dashboards_path, notice: 'ユーザーを有効にしました。'
  end
end
