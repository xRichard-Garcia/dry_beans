RSpec.describe "POST /routes/:route_id/trips/:trip_id/stops", type: :request do
  it "creates a stop" do
    trip = create(:trip)
    post "/api/v1/routes/#{trip.route_id}/trips/#{trip.id}/stops",
      params: { stop: attributes_for(:stop) }

    expect(response).to have_http_status(:created)
  end
end
