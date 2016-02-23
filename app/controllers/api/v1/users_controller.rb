class Api::V1::UsersController < Api::V1::BaseController
  def show
    u = User.find(params[:id])
    render(json: Api::v1::UserSerializer.new(u).to_json)
  end
end
