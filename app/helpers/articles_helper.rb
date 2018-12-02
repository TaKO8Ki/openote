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
    user_articles_likes_count = User.all.map{ |user| [user, user.articles.sum(:likes_count)]}
    user_ranking = user_articles_likes_count.sort_by{ |_, v| -v }
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
end
