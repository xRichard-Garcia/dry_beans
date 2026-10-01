RSpec.describe "GET /routes/:id", type: :request do
  it "returns the route with its trips and stops" do
    route = create(:route)
    trip = create(:trip, route: route)
    create(:stop, trip: trip)

    get "/api/v1/routes/#{route.id}"

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)

    expect(json["included"].count).to eq(2)
    expect(json["included"].map { |i| i["type"] }).to include("stop", "trip")
  end
end
