require 'byebug'

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :conversation

  def index
    @messages = @conversation.messages
  end

  def create
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.status = 1
    if @message.save
      redirect_to @conversation
    else
      render :new
    end
  end

  private

  def conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :status)
  end
end
