FactoryBot.define do
  factory :passenger do
    name { Faker::Name.name }
    booking_id { "" }
  end
end