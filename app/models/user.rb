class User < ApplicationRecord
  self.primary_key = :auth0Id
  has_many :tasks, primary_key: :auth0Id, foreign_key: :author_id
  has_one :profile, primary_key: :auth0Id, foreign_key: :user_id
  has_many :tags, primary_key: :auth0Id, foreign_key: :user_id
  has_and_belongs_to_many :accessories, :join_table => 'accessories_users'
  has_one :companion, foreign_key: :user_id
  has_and_belongs_to_many :joined_rooms, class_name: 'Room', :join_table => 'rooms_users'
  has_many :created_rooms, class_name: 'Room', primary_key: :auth0Id, foreign_key: :author_id
  has_many :user_achievements, class_name: 'UserAchievement'
  has_many :achievements, through: :user_achievements
end