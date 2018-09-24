class Article < ApplicationRecord
    has_many :article_categories, dependent: :destroy
    has_many :categories, :through => :article_categories, dependent: :destroy
    has_many :article_comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    belongs_to :user

    validates :title, presence: true
    validates :body, presence: true

    def self.category_with(name)
        Category.find_by_name!(name).articles
    end

    def user_with
        Article.find_by_user(user).posts
    end

    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end
end
