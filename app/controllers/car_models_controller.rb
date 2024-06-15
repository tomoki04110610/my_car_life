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
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :user_id)
  end

end
