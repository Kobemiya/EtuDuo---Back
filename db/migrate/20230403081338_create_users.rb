class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false , primary_key: :auth0Id do |t|
      t.string :auth0Id, null: false
      t.string :username, null: false

      t.timestamps
      t.index :auth0Id, unique: true
    end
  end
end
