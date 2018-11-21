class FollowRelationshipsController < ApplicationController

    def create
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
        create_notifications
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
       end
    end

    def destroy
        @user = FollowRelationship.find(params[:id]).followed
        current_user.unfollow(@user)
        respond_to do |format|
          format.html { redirect_to @user }
          format.js
        end
    end


    private

    def create_notifications
       return if @user.id == current_user.id
       Notification.create(user_id: @user,
        notified_by_id: current_user.id,
        notified_type: 'follow')
     end


end
