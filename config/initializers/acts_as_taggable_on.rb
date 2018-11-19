ActsAsTaggableOn::Tag.class_eval do
  has_many :user_tags, dependent: :destroy
end
