class Salary < ActiveRecord::Base
  validates :wage, presence: true
  validates :title, presence: true, length: { maximum: 250 }
end
