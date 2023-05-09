class Task < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :tags
  attribute :tags

  def as_json(options = nil)
    json = super.except("author_id")
    json['recurrence'] = json['recurrence'].split(',') if json['recurrence'].present?
    json['tags'].map!{ |tag| tag['id'] }
    json
  end
end
