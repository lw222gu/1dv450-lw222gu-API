class Api::V1::SalarySerializer < Api::V1::BaseSerializer
  attributes :id, :wage, :title
  has_many :tags
  has_one :location, serializer: Api::V1::LocationShortSerializer
end
