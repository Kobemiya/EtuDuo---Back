class CreateCompanion < ActiveRecord::Migration[7.0]
  def change
    create_table :companions do |t|
      t.string :name, null: false
      t.string :skin_color, null: false
      t.references :face, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :hands, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :hair, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :neck, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :torso, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :legs, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :feet, foreign_key: { to_table: :accessories, on_delete: :nullify }
      t.references :user, type: :string, null: false, foreign_key: { to_table: :users, primary_key: :auth0Id, on_delete: :cascade }

      t.timestamps
    end
  end
end