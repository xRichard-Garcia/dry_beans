class Stop < ApplicationRecord
  belongs_to :trip
  enum :stop_type, { pickup: 0, delivery: 1 }
  enum :status, { pending: 0, completed: 1, in_progress: 2, failed: 3 }

  validates :address, :contact_name, :contact_phone, presence: true
  validates :package_count, numericality: { greater_than: 0 }

end
