class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.bigint :author, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.boolean :done, null: false
      t.datetime :start, null: true
      t.datetime :end, null: true

      t.timestamps
    end
  end
end
