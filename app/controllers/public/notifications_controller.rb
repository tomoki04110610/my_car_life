class Public::NotificationsController < ApplicationController
  def generate_notification_message(post)
    case post.genre_id
    when 1
      # ジャンルIDが１の場合（エンジンオイル交換）
      oil_last_change_date = post.created_at.to_date
      days_since_last_change = (Date.today - oil_last_change_date).to_i
      
      if days_since_last_change > default_oil_change_days
        message = "次回エンジンオイル交換は#{days_since_last_change - default_oil_change_days}日後です。"
      elsif days_since_last_change == default_oil_change_days
        message = "本日エンジンオイル交換日です。"
      else 
        message = "エンジンオイル交換時期を#{days_since_last_change}日過ぎました。早めに交換しましょう。"
      end
    
    when 2
      # ジャンルIDが２の場合（洗車）
      wash_date = post.created_at.to_date
      days_since_wash = (Date.today - wash_date).to_i
      
      if days_since_wash > default_carwash_days
        message = "次回洗車日は#{days_dince_wash - default_carwash_days}日後です。"
      elsif days_since_wash == default_carwash_days
        message = "本日洗車日です。"
      else
        message = "洗車時期を#{wash_date}日過ぎました。早めに洗車しましょう。"
      end
    end
  end
end