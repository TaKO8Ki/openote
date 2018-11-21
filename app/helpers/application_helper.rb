module ApplicationHelper


  def notification_content(notification)
    if notification.notified_type == "like"
      content = "さんがあなたの投稿にいいねをしました。"
    elsif notification.notified_type == "comment"
      content = "さんがあなたの投稿にコメントしました。"
    elsif notification.notified_type == "follow"
      content = "さんがあなたをフォローしました。"
    end
    return content
  end

  def notified_by(notification)
    user = User.find(notification.notified_by_id)
  end

  def main_url
    "http://localhost:3000"
  end

  def utf8_enforcer_tag
    "".html_safe
  end

end
