class DefaultValue < ApplicationRecord
  belongs_to :user
  belongs_to :car_model

  validates :default_oil_change_mileage, presence: true, numericality: {only_integer: true}
  validates :default_oil_change_days, presence: true, numericality: {only_integer: true}
  validates :default_carwash_days, presence: true, numericality: {only_integer: true}
end
