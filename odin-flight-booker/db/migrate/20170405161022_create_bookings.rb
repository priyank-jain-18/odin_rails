class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
    	t.references :flight, index: true
    	t.timestamps
    end  
  end
end
