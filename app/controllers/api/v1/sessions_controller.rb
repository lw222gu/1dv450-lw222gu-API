class Api::V1::SessionsController < Api::V1::BaseController
  def auth
    resource_owner = ResourceOwner.find_by(username: params[:username])
    if resource_owner && resource_owner.authenticate(params[:password])
      render json: { token: encode_JWT(resource_owner) }
    else
      render json: { status: 401, error: 'Invalid user credentials.' }
    end
  end
end
