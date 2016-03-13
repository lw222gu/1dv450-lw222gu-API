class Api::V1::LocationsController < Api::V1::BaseController
  before_action :offset_params, only: [:index]
  before_action :api_key

  def index
    if params[:search].present?
      locations = Location.near(params[:search], 5)
    else
      locations = Location.all
    end
    if locations
      locations = locations.drop(@offset)
      locations = locations.take(@limit)
    end
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
    render(
      json: Api::V1::LocationSerializer.new(
        location
      )
    )
  end

  def create
    location = Location.new(create_params)
    unless params[:address].present?
      if !params[:latitude].present? || !params[:longitude].present?
        not_acceptable and return
      end
    end

    location.save
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
        longitude: convert_to_decimal(params[:longitude]),
        address: params[:address]
      }
    )
    parameters.require(:location).permit(:latitude, :longitude, :address)
  end
end
