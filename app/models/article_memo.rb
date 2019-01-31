class ArticleMemo < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :user, optional: true

  validates :status, inclusion: { in: %w(private public) }

  scope :sort_in_created_at_order, -> (order) {order("created_at #{order}")}
end
