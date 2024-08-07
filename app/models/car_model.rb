class CarModel < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :driving_distances, dependent: :destroy
  has_many :default_values, dependent: :destroy

  validates :name, presence: true
end
