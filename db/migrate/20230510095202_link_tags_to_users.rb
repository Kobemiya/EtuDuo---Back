class LinkTagsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :user, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id}
  end
end
