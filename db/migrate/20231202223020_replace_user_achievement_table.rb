class ReplaceUserAchievementTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_achievement, :user_achievements
  end
end
