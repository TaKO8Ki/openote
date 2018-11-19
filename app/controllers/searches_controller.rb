class SearchesController < ApplicationController

  def index
    search
  end

  private

  def search
    @key_word = params[:q]
    if params[:q].present?
      if params[:q].present? && params[:tag].present?
        @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
        @articles = Article.tagged_with(params[:tag]).where("title like '%" + params[:q] + "%'")
      else
        @articles = Article.where("title like '%" + params[:q] + "%'")
      end
    elsif params[:tag].present?
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
      @articles = Article.tagged_with(params[:tag]).sort_in_created_at_order("DESC")
    else
      @articles = Article.all.sort_in_created_at_order("DESC")
    end

  end
end
