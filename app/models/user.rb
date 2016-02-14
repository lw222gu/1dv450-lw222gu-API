class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
    validates :password, length: { minimum: 6 }
    has_many :clients
end
