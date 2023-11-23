class UpdateStats < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :stats, :users, column: :user_id, primary_key: :auth0Id, on_delete: :cascade
  end
end
