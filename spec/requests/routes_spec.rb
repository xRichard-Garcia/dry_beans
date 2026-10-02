RSpec.describe "GET /routes/:id", type: :request do
  let(:token) { JsonWebToken.encode({ scope: "dry_beans_api" }) }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  it "returns the route with its trips and stops" do
    route = create(:route)
    trip = create(:trip, route: route)
    create(:stop, trip: trip)

    get "/api/v1/routes/#{route.id}", headers: headers

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)

    expect(json["included"].count).to eq(2)
    expect(json["included"].map { |i| i["type"] }).to include("stop", "trip")
  end
end
