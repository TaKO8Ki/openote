class Repository < ApplicationRecord
  belongs_to :user
  validates :status, inclusion: { in: %w(private public) }

  def public_repo
    self.status == "public"
  end
end
