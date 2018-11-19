class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.references :user, foreign_key: true
      t.integer :tag_id, null: false

      t.timestamps

      t.index :tag_id
      t.index [:tag_id, :user_id], unique: true
    end
  end
end
