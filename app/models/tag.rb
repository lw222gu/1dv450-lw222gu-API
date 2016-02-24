class Tag < ActiveRecord::Base
  validates :tag, presence: true, length: { maximum: 30 }
end
