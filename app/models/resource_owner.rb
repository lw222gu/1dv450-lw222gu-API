class ResourceOwner < ActiveRecord::Base
  has_secure_password
  has_many :salaries
  validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
  validates :password, length: { minimum: 6 }, on: :create
end
