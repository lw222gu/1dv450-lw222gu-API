class Location < ActiveRecord::Base
  # validates :latitude, presence: true
  # validates :longitude, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  has_many :salaries
end
