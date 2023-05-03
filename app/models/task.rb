class Task < ApplicationRecord
  belongs_to :user, foreign_key: :author_id

  def as_json(options = nil)
    super.except("author_id")
  end
end
