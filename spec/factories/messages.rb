FactoryBot.define do
  factory :message do
    user factory: :user
    conversation factory: :conversation
    content { Faker::Lorem.sentence }
    status { true }
    user_id { user.id }
    conversation_id { conversation.id }
  end
end
