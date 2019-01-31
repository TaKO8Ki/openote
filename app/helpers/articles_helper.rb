module ArticlesHelper
  def add_id_and_class_to_markdown(content)
    each_element = Nokogiri::HTML.parse(content)
    headings = each_element.css(".markdown_heading")

    td_in_table = each_element.css("td")
    th_in_table = each_element.css("th")

    id_count = 1
    headings.each do |heading|
      heading["id"] = "chapter_#{id_count}"
      id_count += 1
    end

    td_in_table.each do |td|
      td["class"] = "markdown_td"
    end

    th_in_table.each do |th|
      th["class"] = "markdown_th"
    end

    return each_element
  end

  def popular_users
    user_articles_likes_count = User.where.not(username: nil).map{ |user| [user, user.articles.sum(:likes_count)]}
    user_ranking = user_articles_likes_count.sort_by{ |_, v| -v }
  end

  def article_rankings
  end

  def article_tags(article)
    tags = article.tags.pluck(:name)
  end

  def tags_sorted_desc
    ActsAsTaggableOn::Tag.order("taggings_count DESC")
  end

  def tag_articles_ranking(tag)
    articles_tagged_with_each_tag = Article.tagged_with(tag).order("created_at DESC").limit(5).order("likes_count DESC")
  end

  def random_tags
    ActsAsTaggableOn::Tag.all.map(&:name).sample(5)
  end

  def public_article_memos(article, limit)
    article.article_memos.where(status: "public")
  end

  def current_user_article_memos(article, limit)
    article.article_memos.where(status: "public", user_id: current_user.id).limit(limit)
  end

  def tags_ranking_for_a_last_week
    now = Time.current
    articles_for_this_week = Article.where("created_at > ?", now.beginning_of_week)
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

  def hot_tags
    hot_tags = tags_ranking_for_a_last_week[0..2]
  end

  def related_articles(article)
    article_tags_random = article.tag_list.sample(3)
    related_articles = []
    article_tags_random.each do |tag|
      articles = Article.tagged_with(tag).sort_in_created_at_order("DESC").search_with_status("public").reject{ |article| article == article }
      related_articles += articles
    end
    return related_articles
  end

  def tags_ranking
    ActsAsTaggableOn::Tag.most_used(7).map(&:name)
  end


end
