class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :position
      t.string :name
      t.string :phone
      t.text :duty

      t.timestamps
    end
  end
end
