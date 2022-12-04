FactoryBot.define do
  factory :flight do
    departure_date { Time.zone.today }
    departing_airport { "" }
    arriving_airport { "" }

    trait :morning do
      departure_time { Time.zone.parse('8:00am') }
    end

    trait :afternoon do
      departure_time { Time.zone.parse('2:00pm') }
    end

    trait :evening do
      departure_time { Time.zone.parse('7:00pm') }
    end

    trait :low_price do
      price { 200 }
    end

    trait :mid_price do
      price { 300 }
    end

    trait :high_price do
      price { 400 }
    end

    trait :short_duration do
      duration { 60 }
    end

    trait :medium_duration do
      duration { 120 }
    end

    trait :long_duration do
      duration { 180 }
    end

    factory :morning_flight, traits: %i[morning low_price short_duration]
    factory :afternoon_flight, traits: %i[afternoon low_price short_duration]
    factory :evening_flight, traits: %i[evening low_price short_duration]

    factory :low_price_flight, traits: %i[low_price morning short_duration]
    factory :mid_price_flight, traits: %i[mid_price morning short_duration]
    factory :high_price_flight, traits: %i[high_price morning short_duration]

    factory :short_duration_flight, traits: %i[short_duration morning low_price]
    factory :medium_duration_flight, traits: %i[medium_duration morning low_price]
    factory :long_duration_flight, traits: %i[long_duration morning low_price]
  end
end