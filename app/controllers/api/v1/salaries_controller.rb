class Api::V1::SalariesController < ApplicationController
  def show
    salary = Salary.find(params[:id])
    render(json: Api::V1::SalarySerializer.new(salary).to_json)
  end
end
