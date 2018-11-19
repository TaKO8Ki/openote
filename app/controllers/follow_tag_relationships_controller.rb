class FollowTagRelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
    @follow = UserTag.create(user_id: current_user.id, tag_id: params[:tag_id])
    @follows = UserTag.where(tag_id: params[:tag_id])
  end

  def destroy
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    follow = UserTag.find_by(user_id: current_user.id, tag_id: params[:id])
    follow.destroy
    @follows = UserTag.where(tag_id: params[:_id])
  end

end
