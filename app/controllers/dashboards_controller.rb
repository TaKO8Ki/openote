class DashboardsController < ApplicationController
  before_action :search_articles_with_status
  before_action :search_articles_with_some_conditions
  before_action :authenticate_user!

  def dashboards
  end

  private

  def search_articles_with_status
    if params[:status]
      setting_order
      @source_articles = Article.search_with_user(current_user).search_with_status(params[:status]).order(params[:order])
      if params[:status] == "public"
        @kind_of_articles = "公開記事"
      elsif params[:status] == "draft"
        @kind_of_articles = "下書き"
      end
    else
      setting_order
      @source_articles = Article.search_with_user(current_user).search_with_user(current_user).order(params[:order])
      @kind_of_articles = "全ての記事"
    end
  end

  def search_articles_with_some_conditions
    if params[:order].present?
      @articles = @source_articles.order(params[:order])
    elsif params[:d_q].present?
      @articles = @source_articles.search_with_keyword(params[:d_q])
    else
      @articles = @source_articles
    end
  end

  def setting_order
    #デフォルト値設定
    order = "created_at DESC"
    @select_box = [["作成日降順", "created_at DESC"], ["作成日昇順", "created_at ASC"], ["いいねの数降順", "likes_count DESC"], ["いいねの数昇順", "likes_count ASC"]]
    if params[:order]
      case params[:order]
      when "created_at DESC"
        order_list = ["作成日降順", "created_at DESC"]
      when "created_at ASC"
        order_list = ["作成日昇順", "created_at ASC"]
      when "likes_count DESC"
        order_list = ["いいねの数降順", "likes_count DESC"]
      when "likes_count ASC"
        order_list = ["いいねの数昇順", "likes_count ASC"]
      else
        order_list = ["作成日降順", "created_at DESC"]
      end
      @select_box.delete(order_list)
      @select_box.unshift(order_list)
    end
  end

end
