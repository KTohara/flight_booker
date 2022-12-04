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

    trait :atl do
      code { "ATL" }
      location { "Atlanta, GA" }
    end
  end
end