require 'rails_helper'

RSpec.describe Conversation do
  it "is valid with a name and status" do
    conversation = build(:conversation)
    expect(conversation).to be_valid
  end

  it "is invalid without a name" do
    conversation = build(:conversation, name: "")
    conversation.valid?
    expect(conversation.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a status" do
    conversation = build(:conversation, status: "")
    conversation.valid?
    expect(conversation.errors[:status]).to include("can't be blank")
  end

  it "has a default avatar" do
    user = create(:user)
    user.image.attached?
    expect(user.image.attached?).to be true 
  end
end
