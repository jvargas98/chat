FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 12345678 }
    name { 'Alejandro' }
    sequence(:user_name) { |u| "elale#{u}"}
  end
end
