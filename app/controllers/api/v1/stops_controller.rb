# frozen_string_literal: true

module Api
  module V1
    class StopsController < ApplicationController
      def create
        trip = Trip.find(params[:trip_id])
        stop = trip.stops.new(stop_params)

        if stop.save
          render json: StopSerializer.new(stop).serializable_hash, status: :created
        else
          render json: { errors: stop.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def stop_params
        params.require(:stop).permit(
          :stop_type, :status, :contact_name, :contact_phone,
          :address, :latitude, :longitude, :scheduled_at,
          :package_count, :notes, :signature_url
        )
      end
    end
  end
end
