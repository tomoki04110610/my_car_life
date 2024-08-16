class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :car_model, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :likes,dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  has_one_attached :post_image

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where('title = ?', content).or(Post.where('body = ?', content))
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%').or(Post.where('body LIKE ?', content + '%'))
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content).or(Post.where('body LIKE ?', '%' + content))
    else
      Post.where('title LIKE ?', '%' + content + '%').or(Post.where('body LIKE ?', '%' + content + '%'))
    end
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
