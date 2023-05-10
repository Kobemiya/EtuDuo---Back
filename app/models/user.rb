class User < ApplicationRecord
  self.primary_key = :auth0Id
  has_many :tasks, primary_key: :auth0Id, foreign_key: :author_id
  has_one :profile, primary_key: :auth0Id, foreign_key: :user_id
  has_many :tags, primary_key: :auth0Id, foreign_key: :user_id
end
