class Api::V1::SalarySerializer < Api::V1::BaseSerializer
  attributes :id, :wage, :title #, :location #, :tags #, :links
  has_many :tags, serializer: Api::V1::TagShortSerializer
  has_one :location, serializer: Api::V1::LocationShortSerializer

  # def links
    # { self: api_v1_salary_path(object.id) }
  # end

  # def location
    # if object.location_id
      # {
        # id: object.location_id,
        # location_url: api_v1_location_path(object.location_id)
      # }
    # end
  # end

  # def tags
    # tags2 = []
    # if object.tags
      # count = 0
      # object.tags.each do |t|
        # tags2[count] = { id: t.id, tag: t.tag, url: api_v1_tag_path(t.id) }
        # count += 1
        # return { id: t.id, tag: t.tag, url: api_v1_tag_path(t.id) }
      # end
    # end
    # return tags2
  # end
end
