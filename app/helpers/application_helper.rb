module ApplicationHelper
  
  def notification_content(notification)
    if notification.notified_type == "like"
      like_user = User.find(notification.notified_by_id)
      content = "#{like_user.username}さんがあなたの投稿にいいねをしました。"
    elsif notification.notified_type == "comment"
      comment_user = User.find(notification.notified_by_id)
      content = "#{comment_user.username}さんがあなたの投稿にコメントしました。"
    end
    return content
  end

end
