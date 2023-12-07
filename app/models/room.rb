# frozen_string_literal: true

class Room < ApplicationRecord
  def as_json(options = nil)
    json = super
    json['needs_password'] = json['password'].present?
    json.except('author_id', 'password')
  end
end
