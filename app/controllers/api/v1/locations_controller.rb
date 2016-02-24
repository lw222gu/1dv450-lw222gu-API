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

  def create
    location = Location.new(create_params)
    return invalid unless location.valid?
    # TODO: add functionality for returning an error if salary is not valid.
    location.save! # TODO: If not valid, ActiveRecord::recordInvalid. Add rescue.
    render(
      json: location,
      status: 201,
      location: api_v1_location_path(location.id),
      serializer: Api::V1::LocationSerializer
    )
  end

  def destroy
  end

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
