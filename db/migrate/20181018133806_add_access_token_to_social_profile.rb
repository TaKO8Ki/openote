class AddAccessTokenToSocialProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :social_profiles, :access_token, :string
  end
end
