class Location < ActiveRecord::Base
  validates :latitude, presence: true, null: false
  validates :longitude, presence: true, null: false
end
