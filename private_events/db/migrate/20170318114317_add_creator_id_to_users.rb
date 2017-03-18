class AddCreatorIdToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :attended_event, :integer
 # 	add_index :users, :attended_event
  end
end
