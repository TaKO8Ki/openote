class AddDefaultToPageView < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :page_view, :integer, :default => 0
  end
end
