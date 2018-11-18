class DashboardsController < ApplicationController
  before_action :correct_user!
  before_action :user_sorted_articles
  def show
  end

  private
  def correct_user!
    @user = User.find(params[:id])
  end

  def user_sorted_articles
    if params[:created_at_order].present?
      @articles = @user.articles.sort_in_created_at_order(params[:created_at_order])
    elsif params[:updated_at_order].present?
      @articles = @user.articles.sort_in_updated_ats_order(params[:updated_at_order])
    else
      @articles = @user.articles
    end
  end

end
