class ChangeUserIdToRepository < ActiveRecord::Migration[5.2]
  def change
    change_column :repositories, :user_id, :integer
  end
end
