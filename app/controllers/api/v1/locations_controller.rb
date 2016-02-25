class Api::V1::LocationsController < Api::V1::BaseController
  before_action :offset_params, only: [:index]

  def index
    locations = Location.limit(@limit).offset(@offset)
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

  def create
    location = Location.new(create_params)
    return not_acceptable unless location.valid?
    # If not valid, ActiveRecord::recordInvalid rescue in BaseController
    location.save!
    render(
      json: location,
      status: 201,
      location: api_v1_location_path(location.id),
      serializer: Api::V1::LocationSerializer
    )
  end

  # No actions for update and delete,
  # since that would affect many users and not only one

  private

  def create_params
    parameters = ActionController::Parameters.new(
      location:
      {
        latitude: convert_to_decimal(params[:latitude]),
        longitude: convert_to_decimal(params[:longitude])
      }
    )
    parameters.require(:location).permit(:latitude, :longitude)
  end
end
