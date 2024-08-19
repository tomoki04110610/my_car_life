class DrivingDistance < ApplicationRecord
  belongs_to :user
  belongs_to :car_model
  belongs_to :post

  validates :distance, presence: true, numericality: {only_integer: true}
end
