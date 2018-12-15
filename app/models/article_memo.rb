class ArticleMemo < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :user, optional: true

  validates :status, inclusion: { in: %w(private public) }
end
