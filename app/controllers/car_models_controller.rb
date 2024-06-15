class CarModelsController < ApplicationController
  def new
    @car_model = Car_model.new
  end

  def create
    car_model = Car_model.new(car_model_params)
    car_model.save
    redirect_to '/users/:id'
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def car_model_params
    params.require(:car_model).permit(:name, :user_id)
  end

end
