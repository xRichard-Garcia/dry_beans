FactoryBot.define do
  factory :stop do
    association :trip
    stop_type { :delivery }
    status { :pending }
    contact_name { Faker::Name.name }
    contact_phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    scheduled_at { 1.day.from_now }
    package_count { rand(1..10) }
    notes { "Dejar en conserjería" }

    trait :pickup do
      stop_type { :pickup }
    end

    trait :completed do
      status { :completed }
      completed_at { Time.current }
    end
  end
end