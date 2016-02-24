class Api::V1::TagSerializer < Api::V1::BaseSerializer
  attributes :id, :tag
  has_many :salaries, serializer: Api::V1::SalaryShortSerializer
end
