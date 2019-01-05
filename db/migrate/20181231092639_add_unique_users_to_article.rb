class AddUniqueUsersToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :unique_users, :integer
  end
end
