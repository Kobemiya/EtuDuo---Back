# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :user, foreign_key: :author_id

  def as_json(options = nil)
    json = super
    json['user_count'] = users.length
    json['needs_password'] = json['password'].present?
    json.except('author_id', 'password')
  end
end
