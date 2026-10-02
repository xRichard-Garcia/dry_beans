class Route < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_many :stops, through: :trips

  validates :name, presence: true
  enum :status, { active: 0, completed: 1, cancelled: 2 }
end
