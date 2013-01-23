class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.text :task
      t.text :result
      t.integer :period

      t.references :employee

      t.timestamps
    end
  end
end
