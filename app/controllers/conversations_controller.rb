class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: %i[show edit update destroy]

  def index
    @conversations = current_user.conversations
  end

  def show; end

  def new
    @conversation = current_user.conversations.build
  end

  def edit; end

  def create
    @conversation = current_user.conversations.build(conversation_params)
    @conversation.status = 1
    if @conversation.save
      render :show, status: :created, location: @conversation
    else
      render :new
    end
  end

  def update
    if @conversation.update(conversation_params)
      redirect_to @conversation
    else
      render :edit
    end
  end

  def destroy
    @conversation.destroy
    redirect_to root_path
  end

  private

  def set_conversation
    @conversation = current_user.conversations.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:name, :status)
  end
end