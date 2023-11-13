# db/migrate/XXXXXXXXXXXXXX_create_users_achievements.rb

class CreateUsersAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :user_achievement do |t|
      t.references :user,name: :user_id, type: :string, foreign_key: { to_table: :users, primary_key: :auth0Id}
      t.references :achievement, foreign_key: { to_table: :achievements }
      t.date :achieved_date

      t.timestamps
    end
  end
end
