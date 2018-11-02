class ArticleMemo < ActiveRecord::Migration[5.2]
  def change
    drop_table :article_memos
  end
end
