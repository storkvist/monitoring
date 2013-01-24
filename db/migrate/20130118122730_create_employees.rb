class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :position
      t.string :name
      t.string :phone
      t.text :comments

      t.timestamps
    end
  end
end
