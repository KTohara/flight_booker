FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'passsword' }
    password_confirmation { 'passsword' }
  end
end