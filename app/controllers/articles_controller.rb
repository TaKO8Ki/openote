class ArticlesController < ApplicationController

    def index
        @likes = Like.where(article_id: params[:article_id])
        @articles_likes_order = Article.all.order('likes_count DESC')
        if params[:category]
            @articles = Article.category_with(params[:category]).order('created_at DESC')
            @category = Category.find_by_name(params[:category])
        else
            @articles = Article.all.order('created_at DESC')
        end
    end

    def show
        @like = Like.where(article_id: params[:article_id])
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user_id = current_user.id
        if @article.save
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

private

def article_params
    params.require(:article).permit(:title, :body, :github_repository_url, :service_url, { :category_ids => [] })
end


end
