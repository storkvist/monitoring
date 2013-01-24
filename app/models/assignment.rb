# encoding: utf-8

class Assignment < ActiveRecord::Base
  PERIOD_DAY      = 5
  PERIOD_WEEK     = 1
  PERIOD_MONTH    = 2
  PERIOD_QUARTER  = 3
  PERIOD_YEAR     = 4

  attr_accessible :period, :task, :instruction_id

  belongs_to :instruction
  has_many :results

  validates_presence_of :instruction_id, :task

  default_scope order('period ASC, task ASC')

  def period_name
    case self.period
      when PERIOD_DAY
        'день'
      when PERIOD_WEEK
        'неделя'
      when PERIOD_MONTH
        'месяц'
      when PERIOD_QUARTER
        'квартал'
      when PERIOD_YEAR
        'год'
      else
        raise 'Неизвестный период'
    end
  end
end
