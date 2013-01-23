class Employee < ActiveRecord::Base
  attr_accessible :duty, :name, :phone, :position, :salary, :department_id

  belongs_to :department

  has_many :assignments

  validates_presence_of :department_id, :position, :name, :duty

  default_scope order('name ASC')

  def self.search(query)
    Employee.where(
      "to_tsvector('ru', name) @@ plainto_tsquery('ru', '#{query}')"
    )
  end
end
