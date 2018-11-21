class RemoveArticleIdFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_reference :notifications, :article_id, index: true, foreign_key: true
  end
end
