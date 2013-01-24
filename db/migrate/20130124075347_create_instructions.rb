class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.text :details
      t.references :employee

      t.timestamps
    end
  end
end
