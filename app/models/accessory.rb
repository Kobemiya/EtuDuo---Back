class Accessory < ApplicationRecord
  enum :body_part, [ :hair, :hands, :face, :neck, :torso, :legs, :feet, :mouth, :eyes ]
end
