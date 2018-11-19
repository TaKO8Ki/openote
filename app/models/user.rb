class User < ApplicationRecord
  validates :description, length: { in: 1..75 }

  has_many :articles
  has_many :active_relationships,  class_name:  "FollowRelationship",
                                 foreign_key: "follower_id",
                                 dependent:   :destroy
  has_many :passive_relationships, class_name:  "FollowRelationship",
                                foreign_key: "followed_id",
                                dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :article_memos, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :user_tags, dependent: :destroy
  mount_uploader :picture, PictureUploader

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :lockable, :timeoutable, :omniauthable, :omniauth_providers => [:github]



  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def follow(other_user)
      active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
      following.include?(other_user)
  end

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  def github_repository(user)
    user_token = access_token_of_each_of_providers(user, "github")
    github = Github.new oauth_token: "#{user_token}"
    user_repos = github.repos.list
  end

end
