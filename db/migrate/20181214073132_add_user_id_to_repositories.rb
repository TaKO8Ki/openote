class AddUserIdToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :user_id, :string
    add_column :repositories, :integer, :string
  end
end
