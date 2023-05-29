class FixCascadeDeleteOnAccessoriesUsersToAccessoriesFk < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :accessories_users, :accessories
    add_foreign_key :accessories_users, :accessories, on_delete: :cascade
  end
end
