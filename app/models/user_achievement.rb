# frozen_string_literal: true

class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  # TODO might wanna remove this if its fields are not used, as it is bad practice and causes problems
end
