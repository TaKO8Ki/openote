class AddAccessSecretToSocialProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :social_profiles, :access_secret, :string
  end
end
