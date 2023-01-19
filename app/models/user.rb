class User < ApplicationRecord
  has_secure_password validations: false

  validates :user_id, presence: true
  validates :password, presence: true
end
