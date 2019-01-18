class DashboardsController < ApplicationController
  before_action :search_articles_with_status
  before_action :search_articles_with_some_conditions
  before_action :authenticate_user!

  def index
  end

  def show
    @article = Article.find_by(id: params[:id], user_id: current_user.id)
    @toc = markdown_toc(view_context.markdown(@article.body))
  end

  private

  def search_articles_with_status
    if params[:status]
      setting_order
      if params[:order] == "pv_count DESC" || params[:order] == "pv_count ASC"
        page_view_ranking = Article.where(user_id: current_user.id, status: params[:status]).map{ |ranking| {article: ranking, pv: page_view(ranking)}}.sort_by! { |a| a[:pv] }
        if params[:order] == "pv_count DESC"
          page_view_ranking.reverse!
        end
        @source_articles = page_view_ranking.map{ |ranking| ranking[:article] }
      else
        @source_articles = Article.search_with_user(current_user).search_with_status(params[:status])
      end
      if params[:status] == "public"
        @kind_of_articles = "公開記事"
      elsif params[:status] == "draft"
        @kind_of_articles = "下書き"
      end
    else
      setting_order
      if params[:order] == "pv_count DESC" || params[:order] == "pv_count ASC"
        page_view_ranking = Article.where(user_id: current_user.id).map{ |ranking| {article: ranking, pv: page_view(ranking)}}.sort_by! { |a| a[:pv] }
        if params[:order] == "pv_count DESC"
          page_view_ranking.reverse!
        elsif params[:order] == "pv_count ASC"
        end
        @source_articles = page_view_ranking.map{ |ranking| ranking[:article] }
      else
        @source_articles = Article.search_with_user(current_user).sort_in_created_at_order("DESC")
      end
      @kind_of_articles = "全ての記事"
    end
  end

  def search_articles_with_some_conditions
    if params[:order].present?
      if params[:order] == "pv_count DESC" || params[:order] == "pv_count ASC"
        @articles =@source_articles
      else
        @articles = @source_articles.order(params[:order])
      end
    elsif params[:d_q].present?
      @articles = @source_articles.search_with_keyword(params[:d_q])
    else
      @articles = @source_articles
    end
  end

  def setting_order
    #デフォルト値設定
    order = "created_at DESC"
    @select_box = [["作成日降順", "created_at DESC"], ["作成日昇順", "created_at ASC"], ["いいねの数降順", "likes_count DESC"], ["いいねの数昇順", "likes_count ASC"], ["PVの数降順", "pv_count DESC"], ["PVの数昇順", "pv_count ASC"]]
    if params[:order]
      case params[:order]
      when "created_at DESC"
        order_list = ["作成日降順", "created_at DESC"]
      when "created_at ASC"
        order_list = ["作成日昇順", "created_at ASC"]
      when "likes_count DESC"
        order_list = ["いいねの数降順", "likes_count DESC"]
      when "likes_count ASC"
        order_list = ["いいねの数昇順", "likes_count ASC"]
      when "pv_count DESC"
        order_list = ["PVの数降順", "pv_count DESC"]
      when "pv_count ASC"
        order_list = ["PVの数昇順", "pv_count ASC"]
      else
        order_list = ["作成日降順", "created_at DESC"]
      end
      @select_box.delete(order_list)
      @select_box.unshift(order_list)
    end
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

  def page_view(article)
    Article.get_counter(:page_view, article.id)
  end

end
