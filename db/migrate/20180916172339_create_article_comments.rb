class CreateArticleComments < ActiveRecord::Migration[5.2]
  def change
      create_table :article_comments do |t|
          t.string :body
          t.references :article, foreign_key: true

          t.timestamps
    end
  end
end
