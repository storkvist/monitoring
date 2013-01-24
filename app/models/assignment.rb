# encoding: utf-8

class Assignment < ActiveRecord::Base
  attr_accessible :task, :instruction_id

  belongs_to :instruction
  has_many :results

  validates_presence_of :instruction_id, :task

  default_scope order('task ASC')
end
