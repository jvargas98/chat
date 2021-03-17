require 'rails_helper'

describe Room do
  it "is valid with an user_id and conversation_id" do
    room = create(:room)
    expect(room).to be_valid
  end

  it "is invalid without an user_id" do
    room = build(:room, user_id: "")
    room.valid?
    expect(room.errors[:user]).to include("must exist")
  end

  it "is invalid without a conversation_id" do
    room = build(:room, conversation_id: "")
    room.valid?
    expect(room.errors[:conversation]).to include("must exist")
  end
end
