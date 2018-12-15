class StocksController < ApplicationController
  before_action :set_article

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
end
