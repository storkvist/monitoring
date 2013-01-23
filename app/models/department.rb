class Department < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :employees

  validates_presence_of :name

  default_scope order('name ASC')

  def total_salary
    self.employees.inject(0) do |sum, employee|
      sum += employee.salary
      sum
    end
  end
end
