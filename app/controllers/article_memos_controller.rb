class ArticleMemosController < ApplicationController

  def index
    if params[:user_id]
      @article_memos = ArticleMemo.where(user_id: params[:user_id])
    elsif params[:article_id]
      @article_memos = ArticleMemo.where(article_id: params[:article_id])
    end
  end

  def new
    @article = Article.find(params[:article_id])
    @article_memo = @article.article_memos.new
  end

  def show
    @article_memo = ArticleMemo.find(params[:id])
  end

  def create
    @article = Article.find(params[:article_id])
    @article_memo = @article.article_memos.new(article_memo_params)
    @article_memo.user_id = current_user.id
    if @article_memo.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end 

  def destroy
      @article = Article.find(params[:article_id])
      @memo = @article.article_memos.find(params[:id])
      @memo.destroy
      redirect_to article_path(@article)
  end

  private
  def article_memo_params
      params.require(:article_memo).permit(:title, :body, :user_id, :article_id)
  end
end
