class Salary < ActiveRecord::Base
  validates :salary, presence: true
  validates :title, presence: true, length: { maximum: 250 }
end
