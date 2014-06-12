class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers, :id => false do |t|
      t.primary_key :phone
      t.string :password

      t.timestamps
    end
    add_index :passengers, :phone
  end
end
