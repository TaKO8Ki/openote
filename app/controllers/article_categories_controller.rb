class ArticleCategoriesController < ApplicationController
    before_action :set_article_category, only: [:show, :edit, :update, :destroy]

    def index
      @article_category = ArticleCategory.all
  end

  def show
  end

  def new
      @article_category = ArticleCategory.new
  end

  def edit
  end

  def create
      @article_category = ArticleCategory.new(article_category_params)]
      if @article_category.save
          redirect_to article_categories_path
      else
          render :new
      end
  end

  def update
      if @article_category.update(article_category_params)
          redirect_to article_categories_path
      else
          render :edit
      end
  end

  def destroy
      if @article_category.destroy(article_category_params)
          redirect_to article_categories_path
      else
          render :index
      end
  end


  private
    def set_article_category
      @article_category = ArticleCategory.find(params[:id])
    end


    def article_category_params
      params.require(:article_category).permit(:post_id, :category_id)
    end
end
