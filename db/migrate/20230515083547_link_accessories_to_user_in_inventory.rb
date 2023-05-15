class LinkAccessoriesToUserInInventory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :accessories
  end
end
