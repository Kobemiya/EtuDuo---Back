class Companion < ApplicationRecord
  has_and_belongs_to_many :accessories, :join_table => 'accessories_companions'
  attribute :accessories

  def as_json(options = nil)
    super.except('user_id')
  end
end
