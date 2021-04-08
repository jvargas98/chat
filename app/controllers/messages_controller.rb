class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_conversation, except: [:edit, :update, :show] 

  def index
    @messages = @conversation.messages
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to @message.conversation
    else
      redirect_to root_path
    end
  end

  def show
    @message = Message.find(params[:id])
    @conversation = @message.conversation
  end

  def edit
  end

  def update
    @message = Message.find(params[:id])
    if MessageDeleter.call(@message, message_params)
      redirect_to @message.conversation
    else
      redirect_to root_path
    end
  end

  private

  def get_conversation
    @conversation = current_user.conversations.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit!
  end
end
