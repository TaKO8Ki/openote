class SocialProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!

  def destroy
    @profile.destroy
    redirect_to user_path(@user)
  end

  private
  def correct_user!
    @user = User.find(params[:user_id])
    @profile = @user.social_profiles.find(params[:id])
  end
end
