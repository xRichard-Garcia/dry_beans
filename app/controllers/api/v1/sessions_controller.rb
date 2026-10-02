# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Api::BaseController
      skip_before_action :authenticate_request!

      def create
        if params[:api_key] == ENV["API_KEY"]
          token = JsonWebToken.encode({ scope: "dry_beans_api" })
          render json: { token: token }, status: :ok
        else
          render json: { error: "Credenciales inválidas" }, status: :unauthorized
        end
      end
    end
  end
end
