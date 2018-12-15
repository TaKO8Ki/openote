class Stock < ApplicationRecord
  belongs_to :article, counter_cache: :stocks_count
  belongs_to :user
  validates :article_id, presence: true
  validates :user_id, presence: true
end
