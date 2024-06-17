class DrivingDistance < ApplicationRecord
  belongs_to :user
  belongs_to :car_model

  validates :distance, presence: true
end
