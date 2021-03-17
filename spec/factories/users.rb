FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 12345678 }
    name { 'Alejandro' }
    sequence(:user_name) { |u| "elale#{u}"}
  end
end

def user_with_messages(messages_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:message, messages_count, user: user)
  end
end

