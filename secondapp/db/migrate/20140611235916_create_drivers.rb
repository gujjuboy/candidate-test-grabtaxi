class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :phone
      t.float :lat, :limit => 30
      t.float :long, :limit => 30
      t.timestamps
    end
  end
end
