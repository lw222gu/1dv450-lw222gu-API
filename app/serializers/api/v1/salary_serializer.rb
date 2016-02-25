class Api::V1::SalarySerializer < Api::V1::BaseSerializer
  attributes :id, :wage, :title, :tags, :location, :links, :resource_owner

  def links
    { self: api_v1_salary_path(object.id) }
  end

  def location
    if object.location_id
      {
        id: object.location_id,
        location_url: api_v1_location_path(object.location_id)
      }
    end
  end

  def tags
    tags = []
    if object.tags
      count = 0
      object.tags.each do |t|
        tags[count] = { id: t.id, tag: t.tag, url: api_v1_tag_path(t.id) }
        count += 1
      end
    end
    return tags
  end

  def resource_owner
    if object.resource_owner_id
      {
        id: object.resource_owner_id,
        username: ResourceOwner.find(object.resource_owner_id).username,
        resource_owner_url: api_v1_resource_owner_path(object.resource_owner_id)
      }
    end
  end
end
