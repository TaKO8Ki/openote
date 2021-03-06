module NotificationsHelper

  def notification_content(notification)
    if notification.notified_type == "like"
      like_user = User.find(notification.notified_by_id)
      content = "#{like_user.username}さんがあなたの投稿にいいねをしました。"
    elsif notification.notified_type == "comment"
      comment_user = User.find(notification.notified_by_id)
      content = "#{comment_user.username}さんがあなたの投稿にコメントしました。"
    elsif notification.notified_type == "follow"
      following_user = User.find(notification.notified_by_id)
      content = "#{following_user.username}さんがあなたをフォローしました。"
    end
    return content
  end

  def notified_by(notification)
    User.find(notification.notified_by_id)
  end

  def notification_not_read(notifications)
    notifications.where(read: false)
  end

  def unread_notifications_count(user)
    count = Notification.where(user_id: user.id, read: false).count
    if count > 9
      result = "9+"
    else
      result = count.to_s
    end
    return result
  end


end
