FactoryBot.define do
  factory :message do
    user factory: :user
    conversation factory: :conversation
    content { 'Hi world!, im a test message' }
    status { true }
    user_id { user.id }
    conversation_id { conversation.id }
  end
end
