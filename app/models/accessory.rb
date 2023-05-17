class Accessory < ApplicationRecord
  enum :body_part, [ :hair, :hand, :face, :neck, :torso, :legs, :feet ]
end
