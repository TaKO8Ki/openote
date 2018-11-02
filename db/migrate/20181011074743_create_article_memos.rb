class CreateArticleMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :article_memos do |t|
      t.string :title
      t.string :body
      t.references :article, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
