class Stock < ApplicationRecord
  belongs_to :article, counter_cache: :stocks_count
  belongs_to :user
  validates :article_id, presence: true
  validates :user_id, presence: true


  scope :sort_in_created_at_order, -> (order) {order("created_at #{order}")}
  scope :sort_in_updated_at_order, -> (order) {order("updated_at #{order}")}
end
