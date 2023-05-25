class AddCascadingDelete < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tags_tasks, :tags, on_delete: :cascade
    add_foreign_key :tags_tasks, :tasks, on_delete: :cascade

    remove_foreign_key :accessories_users, :accessories
    add_foreign_key :accessories_users, :accessories
    remove_foreign_key :accessories_users, :users, column: :user_id, primary_key: :auth0Id
    add_foreign_key :accessories_users, :users, on_delete: :cascade, column: :user_id, primary_key: :auth0Id

    remove_foreign_key :tasks, :users, column: :author_id, primary_key: :auth0Id
    add_foreign_key :tasks, :users, column: :author_id, on_delete: :cascade, primary_key: :auth0Id

    remove_foreign_key :tags, :users, column: :user_id, primary_key: :auth0Id
    add_foreign_key :tags, :users, column: :user_id, on_delete: :cascade, primary_key: :auth0Id

    remove_foreign_key :profiles, :users, column: :user_id, primary_key: :auth0Id
    add_foreign_key :profiles, :users, column: :user_id, on_delete: :cascade, primary_key: :auth0Id
  end
end
