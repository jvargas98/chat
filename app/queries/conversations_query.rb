class ConversationsQuery
  def initialize(user)
    @user = User.find(user.id)
    @conversations = Conversation.all
  end

  def of_current_user
    @user.conversations
  end
end
