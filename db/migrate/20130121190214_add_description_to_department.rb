class AddDescriptionToDepartment < ActiveRecord::Migration
  def change
    change_table :departments do |t|
      t.text :description
    end
  end
end
