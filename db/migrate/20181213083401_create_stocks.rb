class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :article_id, null: false
      t.integer :user_id, null: false

      t.timestamps

      t.index :article_id
      t.index :user_id
      t.index [:article_id, :user_id], unique: true
    end
  end
end
