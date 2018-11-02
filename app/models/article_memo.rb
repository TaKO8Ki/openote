class ArticleMemo < ApplicationRecord
  belongs_to :articles, optional: true
  belongs_to :users, optional: true
end
