# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :users, :join_table => 'rooms_users'

  def as_json(options = nil)
    json = super
    json['needs_password'] = json['password'].present?
    json.except('author_id', 'password')
  end
end
