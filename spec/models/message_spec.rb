require 'rails_helper'

describe Message do
  it "is valid with a content, user_id and conversation_id" do
    message = Message.new(
      content: "This is a message",
      user_id: 1,
      conversation_id: 1)
    expect(message).to be_valid
  end

  it "is invalid without a content" do
    message = Message.new(content: nil)
    message.valid?
    expect(message.errors[:content]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    message = Message.new(user_id: nil)
    message.valid?
    expect(message.errors[:user_id]).to include("can't be blank")
  end

   it "is invalid without a conversation_id" do
    message = Message.new(conversation_id: nil)
    message.valid?
    expect(message.errors[:conversation_id]).to include("can't be blank")
  end
  
  it "returns an alive status as a boolean" do
    message = Message.new(
    content: "This is a message",
    status: true,
    user_id: 1,
    conversation_id: 1)
    expect(message.alive?).to be true
  end
end
