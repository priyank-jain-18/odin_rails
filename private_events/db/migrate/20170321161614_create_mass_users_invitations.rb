class CreateMassUsersInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :mass_users_invitations do |t|
      t.text :multiple_users
      t.integer :event_id

      t.timestamps
    end
  end
end
