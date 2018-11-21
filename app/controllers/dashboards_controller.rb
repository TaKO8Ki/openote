class DashboardsController < ApplicationController
  before_action :search_articles_with_status
  before_action :search_articles_with_some_conditions
  before_action :authenticate_user!

  def show
  end

  private

  def search_articles_with_status
    if params[:status] == "public"
      @source_articles = Article.search_with_user(current_user).search_with_status("public")
      @kind_of_articles = "公開記事"
    elsif params[:status] == "draft"
      @source_articles = Article.search_with_user(current_user).search_with_status("draft")
      @kind_of_articles = "下書き"
    else
      @source_articles = Article.search_with_user(current_user).search_with_user(current_user)
      @kind_of_articles = "全ての記事"
    end
  end

  def search_articles_with_some_conditions
    if params[:created_at_order].present?
      @articles = @source_articles.sort_in_created_at_order(params[:created_at_order])
    elsif params[:updated_at_order].present?
      @articles = @source_articles.sort_in_updated_ats_order(params[:updated_at_order])
    elsif params[:d_q].present?
      @articles = @source_articles.search_with_keyword(params[:d_q])
    else
      @articles = @source_articles
    end
  end

end
