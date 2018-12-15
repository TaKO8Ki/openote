class AddRepoIdToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :repo_id, :integer
  end
end
