class CreateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :stats do |t|
      t.string :user_id, null: false
      t.integer :tasks_done
      t.integer :tasks_created
      t.timestamps
    end
  end
end
