class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.datetime :start_work, null: false
      t.datetime :end_work, null: false
      t.integer :occupation, null: false
      t.integer :prod_period, null: false
      t.datetime :start_sleep
      t.datetime :end_sleep

      t.timestamps
    end

    add_reference :profiles, :user, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id}
  end
end
