class Tag < ActiveRecord::Base
  validates :tag, presence: true, length: { maximum: 30 }
  has_and_belongs_to_many :salaries
end
