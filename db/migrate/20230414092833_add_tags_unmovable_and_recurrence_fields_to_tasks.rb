class AddTagsUnmovableAndRecurrenceFieldsToTasks < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tasks, :tags

    add_column :tasks, :unmovable, :boolean, null: false
    add_column :tasks, :recurrence, :string
  end
end
