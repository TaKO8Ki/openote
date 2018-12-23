class ArticleCommentsController < ApplicationController
    def create
        @article_comment = ArticleComment.new(article_comment_params)
        @article = Article.find(params[:article_id])
        @article_comment.user_id = current_user.id
        @article_comment.article_id = @article.id
        @article_comment.save
        create_notifications
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

    def create_notifications
       return if @article.user.id == current_user.id
       Notification.create(user_id: @article.user.id,
        notified_by_id: current_user.id,
        action_id: @article.id,
        notified_type: 'comment',
        comment_id: @article_comment.id)
     end

end
