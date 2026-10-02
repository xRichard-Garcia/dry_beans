# frozen_string_literal: true

class RouteSerializer
  include JSONAPI::Serializer

  attributes :name

  has_many :trips, serializer: TripSerializer
end
