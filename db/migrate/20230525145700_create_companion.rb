class CreateCompanion < ActiveRecord::Migration[7.0]
  def change
    create_table :companions do |t|
      t.string :name, null: false
      t.string :skin_color, null: false
      t.references :face, foreign_key: { to_table: :accessories }
      t.references :hands, foreign_key: { to_table: :accessories }
      t.references :hair, foreign_key: { to_table: :accessories }
      t.references :neck, foreign_key: { to_table: :accessories }
      t.references :torso, foreign_key: { to_table: :accessories }
      t.references :legs, foreign_key: { to_table: :accessories }
      t.references :feet, foreign_key: { to_table: :accessories }
      t.references :user, type: :string, null: false, foreign_key: { to_table: :users, primary_key: :auth0Id }

      t.timestamps
    end
  end
end