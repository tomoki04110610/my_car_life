class Genre < ApplicationRecord
  has_many :posts
  # enum genre_name: {エンジンオイル交換: 0, 洗車: 1, その他: 2}
  validates :genre_name, presence: true
end
