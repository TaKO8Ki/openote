class UsersController < ApplicationController

  def index
  end

  def show
      @user = User.find(params[:id])
      @category = Category.find_by_name(params[:name])
      @all_articles = Article.where(user_id: @user)
      if @user.social_profiles.where(provider: "github").present?
        @user_repos = github_repository(@user).sort{ |x, y| y.created_at <=> x.created_at }
      end

      if params[:category]
          @articles = Article.tagged_with(params[:category]).where(user_id: @user).order('created_at DESC')
      elsif params[:like]
          @likes = Like.where(user_id: @user)
          @articles = @likes.map{ |like| Article.find(like.article_id) }
      elsif params[:memo]
        @article_memos = ArticleMemo.where(user_id: @user)
        @articles = @article_memos.map{ |memo| Article.find(memo.article_id) }
      else
          @articles = Article.where(user_id: @user).order('created_at DESC').search_with_status("public")
      end
  end

  def following
        @title = "フォロー"
        @nobody = "フォローしている人はいません"
        @user  = User.find(params[:id])
        @users = @user.following
        render 'show_follow'
    end

    def followers
        @title = "フォロワー"
        @nobody = "フォロワーはいません"
        @user  = User.find(params[:id])
        @users = @user.followers
        render 'show_follow'
    end

    private

    def github_repository(user)
      user_token = access_token_of_each_of_providers(user, "github")
      github = Github.new oauth_token: "#{user_token}"
      user_repos = github.repos.list
    end

    def access_token_of_each_of_providers(user, provider)
      access_token = user.social_profiles.find_by(provider: provider).access_token
    end
end
