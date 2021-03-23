FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    user_name { Faker::Internet.unique.username }

    factory :user_with_conversations do
      transient do
        conversations_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:room, evaluator.conversations_count, user_id: user.id) do |room, index|
        room.conversation_id = create(:conversation).id
        end
        user.reload
      end
    end

    factory :user_with_messages do
      transient do
        messages_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:message, evaluator.messages_count, user: user)
        user.reload
      end
    end
  end
end
