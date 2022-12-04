FactoryBot.define do
  factory :airport do

    trait :jfk do
      code { "JFK" }
      location { "New York City, NY" }
    end

    trait :lax do
      code { "LAX" }
      location { "Los Angeles, CA" }
    end
  end
end