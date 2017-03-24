class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :attended_event_id
      t.string :invited_user
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
