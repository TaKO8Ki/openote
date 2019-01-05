class RenameGithubRepositoryUrl < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :github_repository_url, :repository_url
  end
end
