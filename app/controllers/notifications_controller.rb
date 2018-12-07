class NotificationsController < ApplicationController

  def index
    if params[:read] == "true"
      @notifications = Notification.where(user_id:current_user, read: true).order("created_at DESC")
    else
      @notifications = Notification.where(user_id:current_user, read: false).order("created_at DESC")
    end
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
     redirect_to articles_path
   end


end
