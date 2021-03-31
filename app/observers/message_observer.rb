class MessageObserver < ActiveRecord::Observer
  observe :message

  def after_update(message)
    rooms = message.conversation.rooms
    rooms.each do |room|
      UserMailer.with(message: message, user: User.find(room.user_id)).updated_message.deliver_now 
    end
  end

end
