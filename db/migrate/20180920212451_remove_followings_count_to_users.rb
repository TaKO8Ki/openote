class RemoveFollowingsCountToUsers < ActiveRecord::Migration[5.2]
  def change
      remove_column :users, :followings_count, :integer
  end
end
