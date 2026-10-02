# frozen_string_literal: true

module Api
  module V1
    class RoutesController < Api::BaseController
      def show
        route = Route.includes(trips: :stops).find(params[:id])

        render json: RouteSerializer.new(route, include: [:trips, "trips.stops"]).serializable_hash
      end
    end
  end
end
