class Salary < ActiveRecord::Base
  validates :wage, presence: true
  validates :title, presence: true, length: { maximum: 250 }
  has_and_belongs_to_many :tags
  belongs_to :resource_owner
  belongs_to :location

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
