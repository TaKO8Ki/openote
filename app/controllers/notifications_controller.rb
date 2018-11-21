class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(user_id:current_user)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
     redirect_to article_path @notification.article
   end


end
