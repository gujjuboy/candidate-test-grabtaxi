class CreateAssigns < ActiveRecord::Migration
  def change
    create_table :assigns do |t|
      t.integer :booking_id
      t.integer :driver_id

      t.timestamps
    end
  end
end
