RSpec.describe "POST /routes/:route_id/trips/:trip_id/stops", type: :request do
  let(:token) { JsonWebToken.encode({ scope: "dry_beans_api" }) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  it "creates a stop" do
    trip = create(:trip)
    post "/api/v1/routes/#{trip.route_id}/trips/#{trip.id}/stops",
      params: { stop: attributes_for(:stop) },
      headers: headers

    expect(response).to have_http_status(:created)
  end
end
