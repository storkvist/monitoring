class AddEmployeesToDepartment < ActiveRecord::Migration
  def up
    change_table :employees do |t|
      t.references :department
    end
  end

  def down
    change_table :employees do |t|
      remove_column :department_id
    end
  end
end
