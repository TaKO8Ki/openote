class RenameLinkColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :link, :social_link
  end
end
