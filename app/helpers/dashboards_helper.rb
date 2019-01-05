module DashboardsHelper

  def page_view(article)
    Article.get_counter(:page_view, article.id)
  end
end
