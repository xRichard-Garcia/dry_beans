FactoryBot.define do
  factory :route do
    name { Faker::Address.community }
  end
end
