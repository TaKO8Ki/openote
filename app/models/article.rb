class Article < ApplicationRecord
  include MarkdownHelper
  require 'nokogiri'

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

  scope :recent, -> { order(id: :desc).limit(5) }

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
    Article.where("title LIKE ?", keyword)
  end

  def markdown_toc_test(content)
    id_count = 1
    toc_text = ''
    currentlevel = 0

    doc = Nokogiri::HTML.parse(content)
    doc.css('.markdown_heading').each do |h|
      h["id"] = 'chapter_' + id_count.to_s
      id_count += 1

      case h.name
      when 'h2' then
        level = 1
      when 'h3' then
        level = 2
      when 'h4' then
        level = 3
      when 'h5' then
        level = 4
      when 'h6' then
        level = 5
      else
        level = 0
      end


      while currentlevel < level do
          toc_text += '<ul class="chapter">'
          currentlevel += 1
      end

      while currentlevel > level do
          toc_text += '</ul>'
          currentlevel -= 1
      end

      toc_text += '<li><a href="#' + h['id'] + '">' + h.content + "</a></li>\n";
      end

      while currentlevel > 0 do
          toc_text += '</ul>'
          currentlevel -= 1
      end

      toc_text = '<div id=toc><span id=toctitle>目次</span>' + toc_text + '</div>'

      return toc_text
  end

end
