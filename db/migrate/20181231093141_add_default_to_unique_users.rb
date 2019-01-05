class AddDefaultToUniqueUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :unique_users, :integer, :default => 0
  end
end
