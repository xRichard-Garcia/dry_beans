# frozen_string_literal: true

class TripSerializer
  include JSONAPI::Serializer

  attributes :driver_name, :status, :scheduled_date

  has_many :stops, serializer: StopSerializer
end
