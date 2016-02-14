class Client < ActiveRecord::Base
    validates :name, presence: true, length: { maximum: 50 }
    validates :description, length: { maximum: 250 }
    belongs_to :user
end
