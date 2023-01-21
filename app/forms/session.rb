class Session
  include ActiveModel::Model

  attr_accessor :user_id, :password

  validates :user_id, presence: true
  validates :password, presence: true
end