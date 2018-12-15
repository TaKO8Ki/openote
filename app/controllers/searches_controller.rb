class SearchesController < ApplicationController

  def index
    search
  end

  private

  def search
    if params[:q].present?
      if params[:q].present? && params[:tag].present?
        @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
        @articles = Article.tagged_with(params[:tag]).where("title like '%" + params[:q] + "%'").search_with_status("public")
      else
        @articles = Article.where("title like '%" + params[:q] + "%'").search_with_status("public")
      end
    elsif params[:tag].present?
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag])
      @articles = Article.tagged_with(params[:tag]).sort_in_created_at_order("DESC").search_with_status("public")
    else
      @articles = Article.all.sort_in_created_at_order("DESC").search_with_status("public")
    end

  end
end
