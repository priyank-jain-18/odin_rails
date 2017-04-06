class CreatePassengers < ActiveRecord::Migration[5.0]
  def change

    create_table :passengers do |t|
      t.string :email
      t.string :name
      #If you're not familiar with references, it's just shorthand for an integer column that ends with "_id
      t.references :booking, index: true
      t.timestamps
    end
  end
end
