class Location < ActiveRecord::Base
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_many :salaries
end
