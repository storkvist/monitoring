class AddAssignmentsToInstruction < ActiveRecord::Migration
  def change
    change_table :assignments do |t|
      t.references :instruction
    end
  end
end
