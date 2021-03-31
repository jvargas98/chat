FactoryBot.define do
  factory :room do
    user factory: :user
    conversation factory: :conversation
    user_id { user.id }
    conversation_id { conversation.id }
  end
end


