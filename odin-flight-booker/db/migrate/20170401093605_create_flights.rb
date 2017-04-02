class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.integer :departed_from_id
      t.integer :arriving_to_id
      t.datetime :departure_date_time
      t.datetime :arrival_date_time
      t.timestamps
    end    
    add_index :flights, :departed_from_id
    add_index :flights, :arriving_to_id
  end
end
