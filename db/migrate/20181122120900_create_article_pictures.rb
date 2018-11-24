class CreateArticlePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :article_pictures do |t|
      t.integer :user_id
      t.string :picture

      t.timestamps
    end
  end
end
