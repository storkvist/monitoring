class Employee < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :salary, :comments, :department_id

  belongs_to :department

  has_many :instructions

  validates_presence_of :department_id, :position, :name

  default_scope order('name ASC')

  def self.search(query)
    Employee.unscoped.
      all(
        :select => %Q(
          employees.*,
          ts_rank_cd(duties, plainto_tsquery('ru', '#{query}'), 32) AS rank,
          ts_headline(
            'ru',
            task,
            plainto_tsquery('ru', '#{query}'),
            'StartSel=<strong>,StopSel=</strong>'
          ) AS headline
        ),
        :joins => %q(
          JOIN employee_duties ON employee_id = employees.id
          JOIN assignments ON assignments.id = assignment_id
        ),
        :conditions => "duties @@ plainto_tsquery('ru', '#{query}')",
        :order => 'rank DESC'
      )
  end
end
