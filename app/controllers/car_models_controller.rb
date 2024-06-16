class CarModelsController < ApplicationController
  def new
    @car_model = CarModel.new
  end

  def create
    car_model = current_user.car_models.new(car_model_params)
    car_model.save
    redirect_to user_path(current_user.id)
  end

  def edit
    @car_model = CarModel.find(params[:id])
  end

  def update
    car_model = CarModel.find(params[:id])
    car_model.update(car_model_params)
    redirect_to mypage_path
  end

  def destroy
    car_model = CarModel.find(params[:id])
    car_model.destroy
    redirect_to mypage_path
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :user_id)
  end

end
