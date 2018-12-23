class SocialProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!

  def destroy
    if @profile.provider == "github"
      Repository.where(user_id: current_user.id).destroy_all
    end
    @profile.destroy
    flash[:notice] = "外部アプリケーションとの連携を解除しました"
    redirect_to user_path(@user)
  end

  private
  def correct_user!
    @user = User.find(params[:user_id])
    @profile = @user.social_profiles.find(params[:id])
  end
end
