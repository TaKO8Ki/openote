class RemoveIntegerFromRepositories < ActiveRecord::Migration[5.2]
  def change
    remove_column :repositories, :integer, :string
  end
end
