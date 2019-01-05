class StocksController < ApplicationController
  before_action :set_article, only: [:create, :destroy]

  def index
    stocks = Stock.where(user_id: current_user.id)
    @all_stocked_articles = Article.where(id: stocks.map(&:article_id)).sort_in_created_at_order("DESC")
    if params[:tag]
      @stocked_articles = Article.where(id: stocks.map(&:article_id)).tagged_with(params[:tag]).sort_in_created_at_order("DESC")
    else
      @stocked_articles = Article.where(id: stocks.map(&:article_id)).sort_in_created_at_order("DESC")
    end
    kinds_of_tags
  end

  def create
    @stock = Stock.create(user_id: current_user.id, article_id: params[:article_id])
    @stocks = Stock.where(article_id: params[:article_id])
    @article.reload
  end

  def destroy
    stock = Stock.find_by(user_id: current_user.id, article_id: params[:article_id])
    stock.destroy
    @stocks = Stock.where(article_id: params[:article_id])
    @article.reload
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def kinds_of_tags
    @kinds_of_tags = {}
    @all_stocked_articles.includes(:tags).each do |article|
      article.tag_list.each do |tag|
        if @kinds_of_tags[tag].nil?
          @kinds_of_tags[tag] = 1
        else
          @kinds_of_tags[tag] += 1
        end
      end
    end
  end

  def add_article_point_by_stocks
    if @article.is_open_source?
      @article.point.increment(2 * 3/2)
    else
      @article.point.increment(2)
    end
  end

  def remove_article_point_by_stocks
    if @article.is_open_source?
      @article.point.decrement(2 * 3/2)
    else
      @article.point.decrement(2)
    end
  end
end
