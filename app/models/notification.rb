class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User', dependent: :destroy
  belongs_to :user, dependent: :destroy
end
