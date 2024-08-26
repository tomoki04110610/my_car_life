class Admin::UsersController < ApplicationController


  def destroy
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_dashboards_path, notice: 'ユーザーを無効化しました。'
  end
end
