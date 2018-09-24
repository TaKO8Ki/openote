class AddFollowingsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :followings_count, :integer
  end
end
