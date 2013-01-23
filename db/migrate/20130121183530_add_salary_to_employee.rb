class AddSalaryToEmployee < ActiveRecord::Migration
  def change
    change_table :employees do |t|
      t.integer :salary
    end
  end
end
