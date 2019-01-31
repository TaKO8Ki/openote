class ArticlesController < ApplicationController
  require 'nokogiri'
  protect_from_forgery :except => [:new, :edit]
  after_action :tweet_button, only: [:show]

    def index
      if current_user.present? && current_user.username.blank?
        current_user.update(username: current_user.profile_id)
      end
      @likes = Like.where(article_id: params[:article_id])
      @articles_likes_order = Article.all.order('likes_count DESC').limit(10)
      @hot_tags = tags_ranking_for_a_last_week[0..2]
      hot_articles
      which_articles_should_be_showed
    end

    def show
      @like = Like.where(article_id: params[:article_id])
      article = Article.search_with_status("public").find(params[:id])
      @article = article
      other_articles
      @toc = markdown_toc(view_context.markdown(@article.body))
      @user = article.user
      if user_signed_in?
        @like_hash = Like.where(user_id:current_user.id).pluck(:id,:article_id).to_h
        if current_user != article.user
          add_article_page_view
        end
      end
    end

    def new
      set_available_tags_with_count
      @article = Article.new
    end

    def create
      error_title
      @article = Article.new(article_params)
      @article.user_id = current_user.id
      if params[:save_as_draft]
        save_article_as_draft(@article)
      end
      if @article.save
          redirect_to articles_path
      else
          render new_article_path
      end
    end

    def edit
        @article = Article.where(id: params[:id], user_id: current_user.id).first
        set_available_tags_with_count
    end

    def update
        @article = Article.where(id: params[:id], user_id: current_user.id).first
        if @article.update(article_params)
            redirect_to @article.user
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.where(id: params[:id], user_id: current_user.id).first
        @article.destroy
        redirect_to @article.user
    end

    def comment_user(comment)
      User.find(comment.user_id)
    end

helper_method :comment_user, :this_week, :this_month, :this_year

private

  def article_params
      params.require(:article).permit(:title, :body, :repository_url, :service_url, :tag_list, :status, { :picture => [] }, { :category_ids => [] })
  end

  def save_article_as_draft(article)
    article.update(status: "draft")
  end

  def today
    Time.current.beginning_of_day...Time.current.end_of_day
  end

  def this_week
    from  = Time.current.at_beginning_of_week
    to    = (from + 6.day).at_end_of_day
    this_week = from...to
    return this_week
  end

  def this_month
    from  = Time.current.at_beginning_of_month
    to    = (from + 1.month)
    this_month = from...to
    return this_month
  end

  def which_articles_should_be_showed
    articles = Article.search_with_status("public").includes(:tags)
    if params[:group] == "today"
      @articles = articles.search_with_period(today).sort_in_point_desc_order.reject{ |article| @hot_articles.include?(article)}
    elsif params[:group] == "this_week"
      @articles = articles.search_with_period(this_week).sort_in_point_desc_order.reject{ |article| @hot_articles.include?(article)}
    elsif params[:group] == "this_month"
      @articles = articles.search_with_period(this_month).sort_in_point_desc_order.reject{ |article| @hot_articles.include?(article)}
    elsif params[:group] == "time_line"
      @articles = articles.search_with_user(current_user.following).sort_in_point_desc_order
    else
      @articles = articles.sort_in_created_at_order("DESC")
    end
  end

  def hot_articles
    @hot_articles = Article.all.limit(2)
  end

  def set_available_tags_with_count
    tag_list_with_count = []
    tag_list = Article.tags_on(:tags).pluck(:name, :taggings_count)
    tag_list.each do |tag|
      name = tag[0] + '(' + tag[1].to_s + ')'
      tag_list_with_count.push(name)
    end
    gon.available_tags_and_count = tag_list_with_count
  end

  def tags_ranking_for_a_last_week
    now = Time.current
    articles_for_this_week = Article.where("created_at > ?", now.beginning_of_year)
    all_articles_tags = []
    articles_for_this_week.each do |article|
      all_articles_tags.push(article.tag_list)
    end
    all_articles_tags.flatten!

    tags_count = {}
    all_articles_tags.each do |tag|
      if tags_count[tag] == nil
        tags_count[tag] = 1
      else
        tags_count[tag] += 1
      end
    end
    tags_ranking = tags_count.sort_by{ |_, v| -v }
    return tags_ranking
  end

  def markdown_toc(content)
    id_count = 1
    toc_text = ''
    currentlevel = 0

    doc = Nokogiri::HTML.parse(content)
    doc.css('.markdown_heading').each do |h|
      h["id"] = 'chapter_' + id_count.to_s
      id_count += 1

      case h.name
      when 'h2' then
        level = 1
      when 'h3' then
          level = 2
      when 'h4' then
          level = 3
      when 'h5' then
        level = 4
      when 'h6' then
        level = 5
      else
          level = 0
      end

      while currentlevel < level do
          toc_text += '<ul class="chapter">'
          currentlevel += 1
      end

      while currentlevel > level do
          toc_text += '</ul>'
          currentlevel -= 1
      end

      toc_text += '<li class="chapter_list"><a class="anchor" href="#' + h['id'] + '">' + h.content + "</a></li>\n";
      end

      while currentlevel > 0 do
          toc_text += '</ul>'
          currentlevel -= 1
      end

      toc_text = '<div id=toc>' + toc_text + '</div>'

      return toc_text
  end

  def other_articles
    @other_articles = Article.search_with_user(@article.user).sort_in_created_at_order("DESC").limit(3).reject{ |article| article == @article }
  end

  def error_title
    @error_title = ["タイトル", "このURL", "本文"]
  end

  #ソーシャルボタン
  def tweet_button
    @tweet_url = URI.encode(
      "http://twitter.com/intent/tweet?original_referer=" +
      request.url +
      "&url=" +
      request.url +
      "&text=" +
      "記事『" + @article.title + "』を閲覧しています。"
    )
  end

  def add_article_page_view
    @article.page_view.increment(1)
  end

end
