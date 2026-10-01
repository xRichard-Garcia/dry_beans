class Trip < ApplicationRecord
  belongs_to :route
  has_many :stops, dependent: :destroy
  enum :status, { scheduled: 0, ongoing: 1, finished: 2 }
end
