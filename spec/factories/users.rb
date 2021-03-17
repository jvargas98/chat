FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    user_name { Faker::Internet.username }
  end
end

def user_with_messages(messages_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:message, messages_count, user: user)
  end
end

