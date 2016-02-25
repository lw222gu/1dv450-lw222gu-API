class Api::V1::ResourceOwnerSerializer < Api::V1::BaseSerializer
  attributes :id, :username, :links

  def links
    { self: api_v1_resource_owner_path(object.id) }
  end
end
