class Api::V1::ResourceOwnersController < Api::V1::BaseController
  before_action :offset_params, only: [:index]
  before_action :api_key

  def index
    resource_owners = ResourceOwner.limit(@limit).offset(@offset)
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
    render(
      json: Api::V1::ResourceOwnerSerializer.new(
        resource_owner
      )
    )
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
