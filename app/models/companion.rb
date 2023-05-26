class Companion < ApplicationRecord
  has_one :hair, foreign_key: :hair_id
  has_one :face, foreign_key: :face_id
  has_one :neck, foreign_key: :neck_id
  has_one :hands, foreign_key: :hands_id
  has_one :torso, foreign_key: :torso_id
  has_one :legs, foreign_key: :legs_id
  has_one :feet, foreign_key: :feet_id

  def as_json(options = nil)
    super.except('user_id')
  end
end
