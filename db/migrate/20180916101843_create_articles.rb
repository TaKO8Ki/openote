class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
        t.string :title
        t.text :body
        t.string :github_repository_url
        t.string :service_url

      t.timestamps
    end
  end
end
