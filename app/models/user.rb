class User < ApplicationRecord
  self.primary_key = :auth0Id
  has_many :tasks, primary_key: :auth0Id, foreign_key: :author_id
end
