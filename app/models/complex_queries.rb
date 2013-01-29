class ComplexQueries < ActiveRecord::Base
  def self.similar_tasks
    if Rails.env.production?
      similar_function = %q(
        smlar(tsvector2textarray(d1.duties), tsvector2textarray(d2.duties))
      )
    else
      similar_function = 'random()'
    end

    self.connection.execute(sanitize_sql([%Q(
      SELECT
        e1.id               AS e1,
        d1.assignment_id    AS a1,
        e2.id               AS e2,
        d2.assignment_id    AS a2,
      	#{similar_function} AS similarity
      FROM
        employee_duties AS d1, employee_duties AS d2,
        employees AS e1, employees AS e2
      WHERE
        d1.assignment_id != d2.assignment_id
        AND e1.id = d1.employee_id
        AND e2.id = d2.employee_id
        AND #{similar_function} >= 0.5
      ORDER BY similarity DESC #{ 'LIMIT 10' unless Rails.env.production? };
    ), 0.5]))
  end

  def self.count_text_stats
    self.connection.execute(sanitize_sql([%q(
      DELETE FROM text_stat;
      INSERT INTO text_stat (
        SELECT
          q.w,
          count(*)
        FROM (
          SELECT array_to_col(tsvector2textarray(duties)) AS w
          FROM employee_duties
          WHERE duties IS NOT NULL)  AS q
          GROUP BY w
      );
      INSERT INTO text_stat VALUES (
        NULL, (SELECT count(*) FROM employee_duties)
      );
    )]))
  end
end