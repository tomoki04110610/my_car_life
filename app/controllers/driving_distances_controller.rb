class DrivingDistancesController < ApplicationController
  def new
    @driving_distance = DrivingDistance.new
  end

  def create
    driving_distance = DrivingDistance.new(driving_distance_params)
    if driving_distance.save
      redirect_to mypage_path
    else
      redirect_to new_driving_distance_path
    end
  end

  private
  def driving_distance_params
    params.require(:driving_distance).permit(:distance, :car_model_id, :user_id)
  end

end
