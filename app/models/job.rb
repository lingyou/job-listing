class Job < ApplicationRecord
  has_many :resumes, dependent: :destroy
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}
  scope :published, -> {where(is_hidden: false)}
  scope :recent, -> {order("created_at DESC")}
  mount_uploader :attachment, ImageattachmentUploader
  def hide!
    self.is_hidden = true
    self.save
  end
  def publish!
    self.is_hidden = false
    self.save
  end
end
