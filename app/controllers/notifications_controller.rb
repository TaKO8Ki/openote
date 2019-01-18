class NotificationsController < ApplicationController
  after_action :make_notifications_read

  def index
    @notifications = Notification.where(user_id:current_user.id).order("created_at DESC")
  end

  def link_through
    notifications = Notification.where(user_id: current_user.id)
    notifications.update_all(read: true)
    redirect_to notifications_path
   end

   private
   def make_notifications_read
     @notifications.where(read: false).update_all(read: true)
   end


end
