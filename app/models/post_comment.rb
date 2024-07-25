class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  varidates :comment, presence: true
end
