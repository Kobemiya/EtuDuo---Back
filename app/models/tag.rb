class Tag < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true
  attribute :user_id

  def as_json(options = nil)
    json = super
    json['global'] = json['user_id'].nil?
    json.except('user_id')
  end
end
