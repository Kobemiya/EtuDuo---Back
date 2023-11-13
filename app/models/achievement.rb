class Achievement < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :criteria, presence: true
  has_and_belongs_to_many :users, :join_table => 'user_achievements'
end
