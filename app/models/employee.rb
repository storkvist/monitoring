class Employee < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :salary, :comments, :department_id

  belongs_to :department

  has_many :instructions

  validates_presence_of :department_id, :position, :name, :comments

  default_scope order('name ASC')

  def self.search(query)
    Employee.where(
      "to_tsvector('ru', name) @@ plainto_tsquery('ru', '#{query}')"
    )
  end
end
