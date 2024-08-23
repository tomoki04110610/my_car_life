class Public::UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def index
    @users = User.where.not(email: User::GUEST_USER_EMAIL).order(created_at: :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー登録情報の更新に成功しました。"
      redirect_to mypage_path(user.id)
    else
      flash.now[:alert] = "ユーザー登録情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.update(is_active: false)
    sign_out
    flash[:notice] = "退会処理に成功しました。"
    redirect_to new_user_registration_path
  end


  def mypage
    @user = current_user
    @driving_distance = DrivingDistance.new
    @post = Post.new
    generate_notification_messages
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path, alert: "他のユーザーの登録情報は編集できません"
    end
  end

  def generate_notification_messages
    @user.notifications.destroy_all
    @user.car_models.each do |car_model|
      # エンジンオイル交換の通知メッセージ作成
      oil_post = @user.posts.where(car_model_id: car_model.id, genre_id: 1).last
      if oil_post
        oil_last_change_date = oil_post.created_at.to_date
        days_since_last_change = (Date.today - oil_last_change_date).to_i
        latest_driving_distance = oil_post.car_model.driving_distances.last.distance
        distance_traveled = (latest_driving_distance - oil_post.distance)
        defaultvalue = @user.default_values.find_by(car_model_id: car_model.id)
        if defaultvalue == nil
          return
        end
        default_oil_change_days = defaultvalue.default_oil_change_days
        default_oil_change_distance = defaultvalue.default_oil_change_mileage
        if default_oil_change_days < days_since_last_change || default_oil_change_distance < distance_traveled
          oil_message = "#{car_model.name}のエンジンオイル交換時期が過ぎました。早めに交換しましょう。"
        else
          oil_message = "#{car_model.name}の次回エンジンオイル交換は#{default_oil_change_days - days_since_last_change}日後か#{default_oil_change_distance - distance_traveled}km後のどちらか早い方です。"
        end
        @user.notifications.create(message: oil_message, post_id: oil_post.id, car_model_id: car_model.id)
      end

      # 洗車の通知メッセージ作成
      wash_post = @user.posts.where(car_model_id: car_model.id, genre_id: 2).last
      if wash_post
        wash_last_date = wash_post.created_at.to_date
        days_since_last_wash = (Date.today - wash_last_date).to_i
        defaultvalue = @user.default_values.find_by(car_model_id: car_model.id)
        if defaultvalue == nil
          return
        end
        default_wash_days = defaultvalue.default_carwash_days
        if default_wash_days > days_since_last_wash
          wash_message = "#{car_model.name}は#{default_wash_days - days_since_last_wash}日後洗車時期です。"
        else
          wash_message = "洗車時期を過ぎました、早めに洗車をしましょう。"
        end
        @user.notifications.create(message: wash_message, post_id: wash_post.id, car_model_id: car_model.id)
      end
    end
  end
end
