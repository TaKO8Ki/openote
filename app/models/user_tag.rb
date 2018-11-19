class UserTag < ApplicationRecord
  belongs_to :user
  belongs_to :tag, class_name: "ActsAsTaggableOn::Tag"
end
