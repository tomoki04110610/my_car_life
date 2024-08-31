class Public::CarModelsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @car_model = CarModel.new
  end

  def create
    @car_model = current_user.car_models.new(car_model_params)
    if @car_model.save
      current_user.default_values.create(car_model_id: @car_model.id)
      flash[:notice] = "車種登録に成功しました。"
      redirect_to mypage_path
    else
      flash.now[:alert] = "車種登録に失敗しました。"
      render :new
    end
  end

  def edit
    @car_model = CarModel.find(params[:id])
  end

  def update
    @car_model = CarModel.find(params[:id])
    if @car_model.update(car_model_params)
      flash[:notice] = "車種の更新に成功しました。"
       redirect_to mypage_path
    else
      flash.now[:alert] = "車種の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    car_model = CarModel.find(params[:id])
    car_model.destroy
    flash[:notice] = "登録車種の削除に成功しました。"
    redirect_to mypage_path
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :user_id)
  end

  def is_matching_login_user
    car_model = CarModel.find(params[:id])
    unless car_model.user.id == current_user.id
      redirect_to mypage_path, alert: "他のユーザーの登録情報は編集できません"
    end
  end

end
