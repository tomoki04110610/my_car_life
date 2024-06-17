class CarModel < ApplicationRecord
  belongs_to :user
  has_many :driving_distances, dependent: :destroy

  validates :name, presence: true
end
