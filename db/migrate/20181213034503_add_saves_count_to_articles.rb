class AddSavesCountToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :saves_count, :integer
  end
end
