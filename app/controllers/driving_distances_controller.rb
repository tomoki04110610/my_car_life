class DrivingDistancesController < ApplicationController
  def new
    @driving_distance = current_user.driving_distances.new(driving_distance_params)
  end

  def create
    @driving_distance = current_user.driving_distances.new(driving_distance_params)
    if @driving_distance.save
      redirect_to mypage_path
    else
      @driving_distance = current_user.driving_distances.new
      render new
    end
  end

  private
  def driving_distance_params
    params.require(:driving_distance).permit(:distance, :car_model_id, :user_id)
  end

end
