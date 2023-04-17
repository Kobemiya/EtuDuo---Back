class Task < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :tags

  def as_json(options = nil)
    super.except("author_id")
  end
end
