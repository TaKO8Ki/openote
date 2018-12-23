class ArticleComment < ApplicationRecord
    belongs_to :articles, optional: true
    belongs_to :users, optional: true
    
    validates :body, presence: true
end
