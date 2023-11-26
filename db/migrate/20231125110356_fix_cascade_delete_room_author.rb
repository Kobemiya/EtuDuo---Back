class FixCascadeDeleteRoomAuthor < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :rooms, :users, column: :author_id, primary_key: :auth0Id
    add_foreign_key :rooms, :users, on_delete: :cascade, column: :author_id, primary_key: :auth0Id
  end
end
