require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an email, password, name and user_name" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: "")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = build(:user, password: "")
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

   it "is invalid without a name" do
    user = build(:user, name: "")
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a user_name" do
    user = build(:user, user_name: "")
    user.valid?
    expect(user.errors[:user_name]).to include("can't be blank")
  end
  
  it "has a default avatar" do
    user = create(:user)
    user.image.attached?
    expect(user.image.attached?).to be true 
  end
end
