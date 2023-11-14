class RemoveRoomsUsersTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :rooms_users
  end
end
