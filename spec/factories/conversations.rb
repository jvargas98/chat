FactoryBot.define do
  factory :conversation do
    name { Faker::Lorem.word }
    status { true }

  factory :invalid_conversation do
    name { nil }
  end

  factory :conversation_with_users do
    transient do
      users_count { 5 }
  end

    after(:create) do |conversation, evaluator|
      create_list(:room, evaluator.users_count, conversation_id: conversation.id) do |room, index|
        room.user_id = create(:user_with_messages).id
      end
      conversation.reload
     end
   end
  end
end
