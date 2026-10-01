require "rails_helper"

RSpec.describe Stop, type: :model do
  it "is not valid without an address" do
    stop = build(:stop, address: nil)
    expect(stop).not_to be_valid
  end

  it "is valid with valid attributes" do
    stop = build(:stop)
    expect(stop).to be_valid
  end
end
