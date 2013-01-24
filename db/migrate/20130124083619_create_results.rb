class CreateResult < ActiveRecord::Migration
  def change
    create_table :result do |t|
      t.text :details
      t.references :assignment

      t.timestamps
    end
  end
end
