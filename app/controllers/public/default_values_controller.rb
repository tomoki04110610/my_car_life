class Public::DefaultValuesController < ApplicationController
  def edit
    @default_value = DefaultValue.find(params[:id])
  end

  def update
    @default_value = DefaultValue.find(params[:id])
    if @default_value.update(default_value_params)
      flash[:notice] = "通知表示デフォルト編集の更新に成功しました。"
      redirect_to mypage_path(@default_value.user_id)
    else
      flash.now[:alert] = "通知表示デフォルト編集の更新に失敗しました。"
      render :edit
    end
  end

  private
  def default_value_params
    params.require(:default_value).permit(:default_oil_change_mileage, :default_oil_change_days, :default_carwash_days)
  end

  def is_matching_login_user
    @default_value = DefaultValue.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path, alert: "他のユーザーのデフォルト値は編集できません"
    end
  end
end