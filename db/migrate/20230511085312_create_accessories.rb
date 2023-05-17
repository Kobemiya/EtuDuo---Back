class CreateAccessories < ActiveRecord::Migration[7.0]
  def change
    create_table :accessories do |t|
      t.string :name, null: false
      t.string :image_path, null: false
      t.integer :body_part, null: false

      t.timestamps
      t.index :name, unique: true
    end
  end
end
