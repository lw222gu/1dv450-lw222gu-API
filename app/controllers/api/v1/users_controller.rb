class Api::V1::UsersController < ApplicationController
  def show
    u = User.find(params[:id])
    render(json: Api::v1::UserSerializer.new(u).to_json)
  end
end
