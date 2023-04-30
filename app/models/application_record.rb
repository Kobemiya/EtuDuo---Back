class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def as_json(options = nil)
    super.except("created_at", "updated_at")
  end
end
