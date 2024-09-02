class Public::DrivingDistancesController < ApplicationController

  def new
    @driving_distance = current_user.driving_distances.new
    @user_car_models = current_user.car_models
  end

  def create
    @user_car_models = CarModel.where(user_id: current_user.id)
    @driving_distance = current_user.driving_distances.new(driving_distance_params)
    if @driving_distance.save
      flash[:notice] = "走行距離登録に成功しました。"
      redirect_to mypage_path
    else
      flash.now[:alert] = "走行距離登録に失敗しました。"
      @user = current_user
      @post = Post.new
      render "public/users/mypage"
    end
  end

  private
  def driving_distance_params
    params.require(:driving_distance).permit(:distance, :car_model_id)
  end

end
