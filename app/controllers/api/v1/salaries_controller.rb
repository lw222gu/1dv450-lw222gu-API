class Api::V1::SalariesController < Api::V1::BaseController
  before_action :offset_params, only: [:index]
  before_action :api_key
  before_action :api_authenticate, only: [:create, :update, :destroy]

  def index
    salaries = Tag.find(params[:tag_id]).salaries if params[:tag_id].present?
    salaries = ResourceOwner.find(params[:resource_owner_id]).salaries if params[:resource_owner_id].present?
    salaries = Location.find(params[:location_id]).salaries if params[:location_id].present?

    if params[:near].present?
      location = Salary.find(params[:near]).location
      nearby_locations = Location.near(location.address, 5)
      salaries = Array.new
      nearby_locations.each do |nearby_location|
        nearby_location.salaries.each do |nearby_salary|
          salary = Salary.find(nearby_salary)
          salaries.push(salary)
        end
      end
    end

    salaries = Salary.all unless salaries

    if salaries
      salaries = salaries.order(created_at: :desc) if params[:order_by] == 'latest'
      salaries = salaries.drop(@offset)
      salaries = salaries.take(@limit)
    end

    render(
      json: ActiveModel::ArraySerializer.new(
        salaries,
        each_serializer: Api::V1::SalarySerializer,
        root: 'salaries' # root name in response json
      )
    )
  end

  def show
    salary = Salary.find(params[:id])
    render(json: Api::V1::SalarySerializer.new(salary).to_json)
  end

  def create
    salary = Salary.new(create_params.except(:tags, :latitude, :longitude, :address))

    unauthorized unless @current_user
    salary.resource_owner_id = @current_user

    if params[:latitude].present? && params[:longitude].present?
      lat = params[:latitude]
      long = params[:longitude]

      if Location.find_by(latitude: lat, longitude: long)
        salary.location_id = Location.find_by(latitude: lat, longitude: long).id
      else
        salary.location_id = Location.create(latitude: lat, longitude: long).id
      end
    end
    if params[:address].present?
      if Location.find_by(address: params[:address])
        salary.location_id = Location.find_by(address: params[:address]).id
      else
        salary.location_id = Location.create(address: params[:address]).id
      end
    end

    if params[:tags].present?
      tags = params[:tags]
      tags.each do |tag|
        if Tag.find_by(tag: tag)
          salary.tags << Tag.find_by(tag: tag)
        else
          salary.tags << Tag.create(tag: tag)
        end
      end
    end

    return not_acceptable unless salary.valid?
    # If not valid, ActiveRecord::recordInvalid rescue in BaseController
    salary.save
    render(
      json: salary,
      status: 201,
      location: api_v1_salary_path(salary.id),
      serializer: Api::V1::SalarySerializer
    )
  end

  def update
    salary = Salary.find(params[:id])

    return unauthorized unless resource_owner_authentication(salary)

    update_params = create_params
    salary.wage = params[:wage] if update_params[:wage].present?
    salary.title = params[:title] if update_params[:title].present?

    if update_params[:latitude].present? && update_params[:longitude].present?
      lat = params[:latitude]
      long = params[:longitude]

      if Location.find_by(latitude: lat, longitude: long)
        salary.location_id = Location.find_by(latitude: lat, longitude: long).id
      else
        salary.location_id = Location.create(latitude: lat, longitude: long).id
      end
    end

    if params[:address].present?
      if Location.find_by(address: params[:address])
        salary.location_id = Location.find_by(address: params[:address]).id
      else
        salary.location_id = Location.create(address: params[:address]).id
      end
    end

    if params[:tags].present?
      salary.tags.delete_all
      tags = params[:tags]
      tags.each do |tag|
        if Tag.find_by(tag: tag)
          salary.tags << Tag.find_by(tag: tag)
        else
          salary.tags << Tag.create(tag: tag)
        end
      end
    end

    return not_acceptable unless salary.valid?

    if salary.save
      render(
        json: salary,
        status: 200,
        location: api_v1_salary_path(salary.id),
        serializer: Api::V1::SalarySerializer
      )
    else
      not_acceptable
    end
  end

  def destroy
    salary = Salary.find(params[:id])

    return unauthorized unless resource_owner_authentication(salary)

    if salary.destroy
      removed
    else
      not_found
    end
  end

  private

  def create_params
    parameters = ActionController::Parameters.new(
      salary:
      {
        wage: convert_to_integer(params[:wage]),
        title: params[:title],
        tags: params[tags: []],
        latitude: params[:latitude],
        longitude: params[:longitude],
        address: params[:address]
      }
    )
    parameters.require(:salary).permit(
      :wage, :title, :latitude, :longitude, :tags, :address
    )
  end
end
