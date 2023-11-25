class AddCompanionAccessoryTable < ActiveRecord::Migration[7.0]
  def change
    create_table :accessories_companions, id: false do |t|
      t.references :companion, foreign_key: { to_table: :companions, on_delete: :cascade }
      t.references :accessory, foreign_key: { to_table: :accessories, on_delete: :cascade }
      t.index [ :companion_id, :accessory_id ], unique: true
    end
  end
end
