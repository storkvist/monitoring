class Result < ActiveRecord::Base
  attr_accessible :details, :assignment_id

  belongs_to :assignment

  validates_presence_of :details
end
