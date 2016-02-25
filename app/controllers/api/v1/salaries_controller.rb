class Api::V1::SalariesController < Api::V1::BaseController
  def index
    salaries = Salary.all
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
    salary = Salary.new(create_params.except(:tags, :latitude, :longitude))

    if params[:latitude].present? && params[:longitude].present?
      latitude = params[:latitude]
      longitude = params[:longitude]

      if Location.find_by(latitude: latitude, longitude: longitude)
        salary.location_id = Location.find_by(latitude: latitude, longitude: longitude).id
      else
        salary.location_id = Location.create(latitude: latitude, longitude: longitude).id
      end

    end

    if params[:tags].present?
      tags = params[:tags]
      tags.each do |t|
        if Tag.find_by(tag: t)
          salary.tags << Tag.find_by(tag: t)
        else
          salary.tags << Tag.create(tag: t)
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
  end

  def destroy
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
        longitude: params[:longitude]
      }
    )
    parameters.require(:salary).permit(
      :wage, :title, :latitude, :longitude, :tags
    )
  end
end
