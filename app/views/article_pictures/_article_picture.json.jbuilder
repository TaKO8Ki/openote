json.extract! article_picture, :id, :user_id, :picture, :created_at, :updated_at
json.url article_picture_url(article_picture, format: :json)
