class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
  validates :password, length: { minimum: 6 }, on: :create
  has_many :clients
  has_one :role
end
