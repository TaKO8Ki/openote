class AddDefaultToPoinit < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :point, :integer, :default => 0
  end
end
