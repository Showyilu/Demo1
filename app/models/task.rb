class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  scope :active, -> { where(active: true) }
  scope :completed, -> { where(complete: true) }
end
