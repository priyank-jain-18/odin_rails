class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.references :departed_from, index: true
      t.references :arriving_to, index: true
      t.datetime :departure_date_time
      t.datetime :arrival_date_time
      t.timestamps
    end    
  end
end
