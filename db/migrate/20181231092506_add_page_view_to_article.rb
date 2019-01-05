class AddPageViewToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :page_view, :integer
  end
end
