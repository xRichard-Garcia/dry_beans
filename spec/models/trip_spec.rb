require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      trip = build(:trip)
      expect(trip).to be_valid
    end

    it "is not valid without a route" do
      trip = build(:trip, route: nil)
      expect(trip).not_to be_valid
      expect(trip.errors[:route]).to include("must exist")
    end
  end

  describe "associations" do
    it "belongs to a route" do
      route = create(:route)
      trip = create(:trip, route: route)

      expect(trip.route).to eq(route)
    end

    it "has many stops and they are destroyed in a cascade" do
      trip = create(:trip)
      stop = create(:stop, trip: trip)

      expect(trip.stops).to include(stop)
      expect { trip.destroy }.to change { Stop.count }.by(-1)
    end
  end

  describe "enums" do
    it "exposes the possible statuses" do
      expect(Trip.statuses.keys).to match_array(%w[scheduled ongoing finished])
    end

    it "allows setting status by symbol" do
      trip = create(:trip, status: :ongoing)
      expect(trip).to be_ongoing
    end
  end
end