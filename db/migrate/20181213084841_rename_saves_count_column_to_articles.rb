class RenameSavesCountColumnToArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :saves_count, :stocks_count
  end
end
