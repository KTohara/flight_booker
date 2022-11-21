FactoryBot.define do
  factory :passenger do
    name { "MyString" }
    booking { nil }
  end

  factory :booking do
    
  end

  factory :flight do
    departure_date { "2022-11-18" }
    departure_time { "2022-11-18 16:06:07" }
    duration { 1 }
  end

  factory :airport do
    code { "MyString" }
    location { "MyString" }
  end

  factory(:user) do
    username { Faker::Internet.user('username') }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end