class AddPointToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :point, :integer
  end
end
