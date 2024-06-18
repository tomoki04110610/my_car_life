class DrivingDistancesController < ApplicationController
  def new
    @driving_distance = current_user.driving_distances.new
    @user_car_models = current_user.car_models
  end

  def create
    @user_car_models = CarModel.where(user_id: current_user.id)
    @driving_distance = current_user.driving_distances.new(driving_distance_params)
    if @driving_distance.save
      redirect_to mypage_path
    else
      render :new
    end
  end

  private
  def driving_distance_params
    params.require(:driving_distance).permit(:distance, :car_model_id, :user_id)
  end

end
