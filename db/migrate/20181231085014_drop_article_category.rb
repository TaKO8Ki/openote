class DropArticleCategory < ActiveRecord::Migration[5.2]
  def change
    drop_table :article_categories
  end
end
