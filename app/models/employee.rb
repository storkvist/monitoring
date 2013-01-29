class Employee < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :salary, :comments, :department_id

  belongs_to :department

  has_many :instructions

  validates_presence_of :department_id, :position, :name

  default_scope order('name ASC')

  def self.search(query)
    Employee.
      joins('JOIN employee_duties ON id = employee_id').
      where("duties @@ plainto_tsquery('ru', '#{query}')")
  end
end
