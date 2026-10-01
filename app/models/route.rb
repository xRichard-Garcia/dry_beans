class Route < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_many :stops, through: :trips

  validates :name, presence: true
end
