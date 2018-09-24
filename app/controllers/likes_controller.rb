class LikesController < ApplicationController

    def create
        @like = Like.create(user_id: current_user.id, article_id: params[:article_id])
        @likes = Like.where(article_id: params[:article_id])
        @article = Article.find(params[:article_id])
        redirect_to @article

        respond_to do |format|
            format.html {redirect_to controller: :articles, action: :index }
            format.js
        end
    end

    def destroy
        @likes = Like.where(article_id: params[:article_id])
        @article = Article.find(params[:article_id])
        like = Like.find_by(user_id: current_user.id, article_id: params[:article_id])
        like.destroy
        redirect_to @article

        respond_to do |format|
            format.html {redirect_to controller: :articles, action: :index }
            format.js
        end
    end

end
