class ArticleComment < ApplicationRecord
    belongs_to :articles, optional: true 
    validates :body, presence: true
end
