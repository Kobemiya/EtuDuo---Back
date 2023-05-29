class AddLinkAuthorToTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :author
    add_reference :tasks, :author, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id }
  end
end
