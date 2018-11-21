class Article < ApplicationRecord
  has_many :article_categories, dependent: :destroy
  has_many :categories, :through => :article_categories, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :article_memos, dependent: :destroy
  belongs_to :user
  acts_as_taggable

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: %w(draft public) }

  scope :search_with_keyword, -> (keyword) {where("title like '%" + keyword + "%'")}
  scope :search_with_user, -> (user) {where(user_id: user)}
  scope :search_with_status, -> (status) {where(status: status)}
  scope :search_with_period_likes_desc, -> (period) { where(created_at: period).order("likes_count DESC") }
  scope :sort_in_created_at_order, -> (order) {order("created_at #{order}")}
  scope :sort_in_updated_ats_order, -> (order) {order("updated_at #{order}")}
  scope :recent, -> (count) { order(id: :desc).limit(count) }


  def self.category_with(name)
    Category.find_by_name!(name).articles
  end

  def user_with
    Article.find_by_user(user).posts
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def search(keyword)
    self.where("title LIKE ?", keyword)
  end



end
