require "rails_helper"

RSpec.describe Route, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      route = build(:route)
      expect(route).to be_valid
    end

    it "is not valid without a name" do
      route = build(:route, name: nil)
      expect(route).not_to be_valid
      expect(route.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many trips and they are destroyed in a cascade" do
      route = create(:route)
      trip = create(:trip, route: route)

      expect(route.trips).to include(trip)
      expect { route.destroy }.to change { Trip.count }.by(-1)
    end

    it "has many stops through trips" do
      route = create(:route)
      trip = create(:trip, route: route)
      stop = create(:stop, trip: trip)

      expect(route.stops).to include(stop)
    end
  end
end