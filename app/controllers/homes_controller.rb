class HomesController < ApplicationController
  def top
    @posts = Post.order(created_at: :desc).limit(4)
  end

  def about
  end
end
