class Salary < ActiveRecord::Base
  validates :salary, presence: true
end
