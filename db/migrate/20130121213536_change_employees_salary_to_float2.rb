class ChangeEmployeesSalaryToFloat2 < ActiveRecord::Migration
  def up
    change_column :employees, :salary, :decimal
  end

  def down
  end
end
