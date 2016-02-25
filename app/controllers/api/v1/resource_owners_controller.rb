class Api::V1::ResourceOwnersController < Api::V1::BaseController
  def index
  end

  def show
    resource_owner = ResourceOwner.find(params[:id])
    render(json: Api::V1::ResourceOwnerSerializer.new(resource_owner).to_json)
  end

  def create
    # Don't know if this one is necessary
  end

  def update
    # Don't know if this one is necessary
  end

  def destroy
    # Don't know if this one is necessary
  end
end
