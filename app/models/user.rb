class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :car_models, dependent: :destroy
  has_many :driving_distances, dependent: :destroy

  has_one_attached :profile_image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :nickname, presence: true

  GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.nickname = "guestuser"
        user.last_name = "ゲスト"
        user.first_name = "ユーザー"
        user.last_name_kana = "ゲスト"
        user.first_name_kana = "ユーザー"
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end

end
