class Public::DefaultValuesController < ApplicationController
  def edit
    @default_value = DefaultValue.find(params[:id])
  end

  def update
    @default_value = DefaultValue.find(params[:id])
    if @default_value.update(default_value_params)
      flash[:notice] = "通知表示デフォルト編集の更新に成功しました。"
      redirect_to mypage_path(user.id)
    else
      flash.now[:alert] = "通知表示デフォルト編集の更新に失敗しました。"
      render :edit
    end
  end

  private
  def default_value_params
    params.reqire(:default_value).permit(:default_oil_change_mileage, :default_oil_change_days, :default_carwash_days)
  end
end