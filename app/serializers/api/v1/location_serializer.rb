class Api::V1::LocationSerializer < Api::V1::BaseSerializer
  attributes :id, :latitude, :longitude, :salaries

  def salaries
    salaries = []
    if object.salaries
      count = 0
      object.salaries.each do |salary|
        salaries[count] = { id: salary.id, url: api_v1_salary_path(salary.id) }
        count += 1
      end
    end
    salaries
  end
end
