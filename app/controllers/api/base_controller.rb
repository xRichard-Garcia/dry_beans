# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    before_action :authenticate_request!

    private

    def authenticate_request!
      header = request.headers["Authorization"]
      token = header&.split(" ")&.last
      return render json: { error: "Token requerido" }, status: :unauthorized unless token

      decoded = JsonWebToken.decode(token)
      return render json: { error: "Token inválido o expirado" }, status: :unauthorized unless decoded

      @current_scope = decoded[:scope]
    end
  end
end