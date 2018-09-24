class UsersController < ApplicationController
  def index
  end

  def show
      @user = User.find(params[:id])
      @category = Category.find_by_name(params[:name])
      @all_articles = Article.where(user_id: @user)

      if params[:category]
          @articles = Article.category_with(params[:category]).where(user_id: @user).order('created_at DESC')
      elsif params[:like]
          @likes = Like.where(user_id: @user)
          @articles = @likes.map{ |like| Article.find(like.article_id) }
      else
          @articles = Article.where(user_id: @user).order('created_at DESC')
      end
  end

  def following
        @title = "Following"
        @user  = User.find(params[:id])
        @users = @user.following
        render 'show_follow'
    end

    def followers
        @title = "Followers"
        @user  = User.find(params[:id])
        @users = @user.followers
        render 'show_follow'
    end
end
