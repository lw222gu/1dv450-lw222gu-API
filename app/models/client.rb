class Client < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 250 }
  belongs_to :user

  before_create :generate_key

  def generate_key
    loop do
      self.key = SecureRandom.base64(20)
      break unless Client.find_by(key: key)
    end
  end
end
