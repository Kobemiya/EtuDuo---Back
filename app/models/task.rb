class Task < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_and_belongs_to_many :tags

  def get_recurrence
    return { is_recurrent: false } if recurrence.nil?

    possible_days = %w[monday tuesday wednesday thursday friday saturday sunday]
    words = recurrence.split(',').map{|str| str.downcase.strip}
    return { is_recurrent: true, period: "year" } if words.include?('year')

    days_of_week = words.filter{|word| possible_days.include?(word)}
    return { is_recurrent: true, period: "week", days_of_week: days_of_week } if days_of_week.any?

    { is_recurrent: false }
  end

  def as_json(options = nil)
    super.except("author_id")
  end
end
