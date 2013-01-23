class ChangeEmployeesSalaryToFloat < ActiveRecord::Migration
  def up
    change_table :departments do |t|
      t.float :salary
    end
  end

  def down
  end
end
