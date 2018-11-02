class ArticleCommentsController < ApplicationController
    def create
        @article_comment = ArticleComment.new(article_comment_params)
        @article = Article.find(params[:article_id])
        @article_comment.user_id = current_user.id
        @article_comment.article_id = @article.id
        @article_comment.save
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.article_comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end

    private
    def article_comment_params
        params.require(:article_comment).permit(:body, :user_id, :article_id)
    end

end
