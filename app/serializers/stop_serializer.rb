# frozen_string_literal: true

class StopSerializer
  include JSONAPI::Serializer

  attributes :stop_type, :status, :contact_name, :contact_phone,
             :address, :latitude, :longitude, :scheduled_at,
             :completed_at, :package_count, :notes
end