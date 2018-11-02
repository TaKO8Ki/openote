class AddUserIdToArticleComment < ActiveRecord::Migration[5.2]
  def change
    add_column :article_comments, :user_id, :integer
  end
end
