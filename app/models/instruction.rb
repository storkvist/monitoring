class Instruction < ActiveRecord::Base
  attr_accessible :details, :employee_id

  belongs_to :employee
  has_many :assignments

  validates_presence_of :details

  default_scope order('details ASC')
end
