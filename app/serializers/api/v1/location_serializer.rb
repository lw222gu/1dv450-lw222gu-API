class Api::V1::LocationSerializer < Api::V1::BaseSerializer
  attributes :id, :latitude, :longitude
  has_many :salaries, serializer: Api::V1::SalaryShortSerializer
end
