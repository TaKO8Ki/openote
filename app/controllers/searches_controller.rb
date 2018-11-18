class SearchesController < ApplicationController

  def index
    search
  end

  private

  def search
    @key_word = params[:q]
    if params[:q].present?
      if params[:q].present? && params[:category].present?
        @category = params[:category]
        @articles = Article.tagged_with(params[:category]).where("title like '%" + params[:q] + "%'")
      else
        @articles = Article.where("title like '%" + params[:q] + "%'")
      end
    elsif params[:category].present?
      @category = params[:category]
      @articles = Article.tagged_with(params[:category]).sort_in_created_at_order("DESC")
    else
      @articles = Article.all.sort_in_created_at_order("DESC")
    end

  end
end
