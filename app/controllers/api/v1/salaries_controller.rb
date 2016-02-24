class Api::V1::SalariesController < Api::V1::BaseController

  before_action :sanitize_params, only: [:create]

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
    salary = Salary.new(create_params)
    # TODO: add functionality for returning an error if salary is not valid.
    salary.save! # TODO: If not valid, ActiveRecord::recordInvalid. Add rescue.
    render(
      json: salary,
      status: 201,
      location: api_v1_salary_path(salary.id),
      serializer: Api::V1::SalarySerializer
    )
  end

  def destroy
  end

  private

  def create_params
    parameters = ActionController::Parameters.new(
      salary:
      {
        wage: params[:wage],
        title: params[:title]
      }
    )
    parameters.require(:salary).permit(:wage, :title)
  end

  def sanitize_params
    params[:wage] = params[:wage].to_i
  end
end
