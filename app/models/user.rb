class User < ApplicationRecord
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

    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable,
            :confirmable, :lockable, :timeoutable

    def follow(other_user)
        active_relationships.create(followed_id: other_user.id)
    end

    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end

    def following?(other_user)
        following.include?(other_user)
    end

end
