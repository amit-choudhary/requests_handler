class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request

  validates :content, :user, :request, presence: true

  # Scopes..............
  scope :order_by_creation, -> { order(created_at: :desc) }

end
