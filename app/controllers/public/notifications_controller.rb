class Public::NotificationsController < ApplicationController
  def generate_notification_message(post)
    case post.genre_id
    when 1
      oil_last_change_date = post.created_at.to_date
      days_since_last_change = (Date.today - oil_last_change_date).to_i
      
      if days_since_last_change
        
      end
    end
  end
end
