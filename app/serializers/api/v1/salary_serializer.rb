class Api::V1::SalarySerializer < Api::V1::BaseSerializer
  attributes :id, :wage, :title, :links, :location, :tags

  def links
    { self: api_v1_salary_path(object.id) }
  end

  def location
    {
      id: object.location_id,
      location_url: api_v1_location_path(object.location_id)
    }
  end

  def tags
    tags = []
    if object.tags
      count = 0
      object.tags.each do |tag|
        tags[count] = { id: tag.id, tag: tag.tag, url: api_v1_tag_path(tag.id) }
        count += 1
      end
    end
    tags
  end
end
