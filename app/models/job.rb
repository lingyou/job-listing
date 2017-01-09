class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_uppper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}
  validates :wage_uppper_bound, numericality: {greater_than_or_equal_to: :wage_lower_bound}
  scope :publicjobs, -> {where(is_hidden: false)}
  scope :recent, -> {order("created_at DESC")}
end
