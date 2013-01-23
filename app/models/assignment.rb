# encoding: utf-8

class Assignment < ActiveRecord::Base
  PERIOD_WEEK     = 1
  PERIOD_MONTH    = 2
  PERIOD_QUARTER  = 3
  PERIOD_YEAR     = 4

  attr_accessible :period, :task, :result, :employee_id

  belongs_to :employee

  validates_presence_of :employee_id, :task, :result

  default_scope order('period ASC')

  def period_name
    case self.period
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
