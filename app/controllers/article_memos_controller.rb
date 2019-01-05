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
    if current_user != @article.user
      add_article_point_by_memos
    end 
    if params[:save_as_private]
      save_article_memo_as_private(@article_memo)
    end
    if @article_memo.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
    @article_memo = ArticleMemo.find(params[:id])
    set_available_tags_with_count
  end

  def update
    @article_memo = ArticleMemo.find(params[:id])
    if @article_memo.update(article_memo_params)
        redirect_to @article_memo.user
    else
        render 'edit'
    end
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

  def save_article_memo_as_private(article_memo)
    article_memo.update(status: "private")
  end

  def add_article_point_by_memos
    if @article.is_open_source?
      @article.point.increment(6 * 3/2)
    else
      @article.point.increment(6)
    end
  end

end
