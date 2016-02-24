class Api::V1::LocationsController < Api::V1::BaseController
  def index
    locations = Location.all
    render(
      json: ActiveModel::ArraySerializer.new(
        locations,
        each_serializer: Api::V1::LocationSerializer,
        root: 'locations' # root name in response json
      )
    )
  end

  def show
    location = Location.find(params[:id])
    render(json: Api::V1::LocationSerializer.new(location).to_json)
  end
end
