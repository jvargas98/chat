require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid with a content, user_id and conversation_id" do
    message = create(:message)
    expect(message).to be_valid
  end

  it "is invalid without a content" do
    message = build(:message, content: "")
    message.valid?
    expect(message.errors[:content]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    message = build(:message, user_id: "")
    message.valid?
    expect(message.errors[:user_id]).to include("can't be blank")
  end

   it "is invalid without a conversation_id" do
    message = build(:message, conversation_id: "")
    message.valid?
    expect(message.errors[:conversation_id]).to include("can't be blank")
  end
  
  it "returns an alive status as a boolean" do
    message = create(:message)
    expect(message.alive?).to be true
  end
end
