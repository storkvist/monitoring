# encoding: utf-8

class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def top

  end

  def treemap
    data = ["['Зарплатный фонд университета', null, 0]"]

    Department.all.each do |department|
      data.push "['#{department.name}', 'Зарплатный фонд университета', 0]"
    end

    Employee.all.each do |employee|
      data.push "['#{employee.name}, #{employee.position}', " +
                 "'#{employee.department.name}', " +
                 "#{employee.salary}]"
    end
    @data = data.join ','
  end
end
