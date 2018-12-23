class NotificationsController < ApplicationController

  def index
    if params[:read] == "true"
      @notifications = Notification.where(user_id:current_user, read: true).order("created_at DESC")
    else
      @notifications = Notification.where(user_id:current_user, read: false).order("created_at DESC")
    end
  end

  def link_through
    notifications = Notification.where(user_id: current_user.id)
    notifications.update_all(read: true)
    redirect_to notifications_path
   end


end
