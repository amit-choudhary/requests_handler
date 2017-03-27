class Request < ApplicationRecord
  enum status: [:pending, :solved]

  validates :subject, :content, :customer, presence: true
  belongs_to :customer
  belongs_to :support_agent
  has_many :comments, dependent: :destroy

end
