class User < ApplicationRecord
  self.primary_key = :auth0Id
end
