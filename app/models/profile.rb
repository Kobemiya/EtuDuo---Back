class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  enum :occupation, [ :school, :college, :work, :free ]
  enum :prod_period, [ :before, :after, :both ]

  def as_json(options = nil)
    super.except("user_id", "id")
  end
end
