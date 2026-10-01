FactoryBot.define do
  factory :trip do
    association :route
    driver_name { Faker::Name.name }
    vehicule_plate { Faker::Vehicle.license_plate }
    scheduled_date { Date.today }
  end
end
