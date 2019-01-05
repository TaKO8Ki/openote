class RemovePictureFromArticle < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :picture, :json
  end
end
