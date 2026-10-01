# app/controllers/api/v1/routes_controller.rb
module Api
  module V1
    class RoutesController < ApplicationController
      def show
        route = Route.includes(trips: :stops).find(params[:id])

        render json: RouteSerializer.new(route, include: [:trips, "trips.stops"]).serializable_hash
      end
    end
  end
end
