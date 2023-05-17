class LinkAccessoriesToUserInInventory < ActiveRecord::Migration[7.0]
  def change
    create_table :accessories_users, id: false do |t|
      t.references :user, name: :user_id, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id}
      t.references :accessory, foreign_key: { to_table: :accessories }
      t.index [ :user_id, :accessory_id ], unique: true
    end
  end
end
