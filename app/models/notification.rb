class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :car_model
end
