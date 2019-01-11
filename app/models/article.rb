class Article < ApplicationRecord
  has_many :article_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :article_memos, dependent: :destroy
  belongs_to :user
  mount_uploaders :picture, PictureUploader
  acts_as_taggable

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: %w(draft public) }
  validates :repository_url, format: /\A#{URI::regexp(%w(http https))}\z/, if: :is_open_source?

  scope :search_with_keyword, -> (keyword) {where("title like '%" + keyword + "%'")}
  scope :search_with_user, -> (user) {where(user_id: user)}
  scope :search_with_status, -> (status) {where(status: status)}
  scope :search_with_period_likes_desc, -> (period) { where(created_at: period).order("likes_count DESC") }
  scope :sort_in_created_at_order, -> (order) {order("created_at #{order}")}
  scope :sort_in_updated_at_order, -> (order) {order("updated_at #{order}")}
  scope :recent, -> (count) { order(id: :desc).limit(count) }
  scope :likes_desc, -> {order("likes_count DESC")}

  include Redis::Objects
  counter :page_view, :start => 0
  counter :point, :start => 0

  def self.category_with(name)
    Category.find_by_name!(name).articles
  end

  def user_with
    Article.find_by_user(user).posts
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def stock_user(user_id)
    stocks.find_by(user_id: user_id)
  end

  def search(keyword)
    self.where("title LIKE ?", keyword)
  end

  def is_open_source?
    self.repository_url.present?
  end

  def sort_in_page_view_order
    articles_page_view = Article.page_view.map{ |article| Article.get_counter(:page_view, article.id) }

  end

end
