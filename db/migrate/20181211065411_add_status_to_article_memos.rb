class AddStatusToArticleMemos < ActiveRecord::Migration[5.2]
  def change
    add_column :article_memos, :status, :string, default: 'public'
  end
end
