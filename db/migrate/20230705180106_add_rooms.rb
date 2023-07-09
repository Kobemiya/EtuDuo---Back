class AddRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.string :password
      t.references :author, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id }

      t.timestamps
    end

    create_table :rooms_users, id: false do |t|
      t.references :user, name: :user_id, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id}
      t.references :room, foreign_key: { to_table: :rooms }
      t.index [ :user_id, :room_id ], unique: true
    end
  end
end
