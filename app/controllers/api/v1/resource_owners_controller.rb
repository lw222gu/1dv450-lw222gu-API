class Api::V1::ResourceOwnersController < Api::V1::BaseController
  def index
    resource_owners = ResourceOwner.all
    render(
      json: ActiveModel::ArraySerializer.new(
        resource_owners,
        each_serializer: Api::V1::ResourceOwnerSerializer,
        root: 'resource_owners' # root name in response json
      )
    )
  end

  def show
    resource_owner = ResourceOwner.find(params[:id])
    render(json: Api::V1::ResourceOwnerSerializer.new(resource_owner).to_json)
  end

  def create
    resource_owner = ResourceOwner.create(resource_owner_params)
    return not_acceptable unless resource_owner.valid?
    resource_owner.save
    render(
      json: resource_owner,
      status: 201,
      location: api_v1_resource_owner_path(resource_owner.id),
      serializer: Api::V1::ResourceOwnerSerializer
    )
  end

  def update
    # Don't know if this one is necessary
  end

  def destroy
    # Don't know if this one is necessary
  end

  def resource_owner_params
    parameters = ActionController::Parameters.new(
      resource_owner:
      {
        username: params[:username],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      }
    )
    parameters.require(:resource_owner).permit(:username, :password, :password_confirmation)
  end
end
