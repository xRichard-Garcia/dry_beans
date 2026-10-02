# frozen_string_literal: true

RSpec.describe "POST /api/v1/login", type: :request do
  context "with valid api_key" do
    before { ENV["API_KEY"] = "valid_key" }

    it "returns a JWT token" do
      post "/api/v1/login", params: { api_key: "valid_key" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["token"]).to be_present
    end
  end

  context "with invalid api_key" do
    before { ENV["API_KEY"] = "valid_key" }

    it "returns unauthorized" do
      post "/api/v1/login", params: { api_key: "invalid_key" }

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(response.body)
      expect(json["error"]).to eq("Credenciales inválidas")
    end
  end
end
