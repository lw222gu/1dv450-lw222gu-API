class Api::V1::SalarySerializer < Api::V1::BaseSerializer
  attributes :id, :wage, :title, :links, :location
  has_many :tags
  # has_one :location, serializer: Api::V1::LocationShortSerializer

  def links
    { self: api_v1_salary_path(object.id) }
  end

  def location
    {
      id: object.location_id,
      location_url: api_v1_location_path(object.location_id)
    }
  end
end
