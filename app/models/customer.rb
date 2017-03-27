class Customer < User
  has_many :requests, dependent: :nullify
end
