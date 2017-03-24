class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :creator_id
      t.string :title
      t.text :description
      t.datetime :event_start_date

      t.timestamps
    end    
    #add_index :events, :creator_id
  end

end
