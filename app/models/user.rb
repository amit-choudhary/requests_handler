class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  TYPES = %w(Customer Admin SupportAgent)

  validates :type, presence: true
  validates :type, inclusion: { in: TYPES }
end
