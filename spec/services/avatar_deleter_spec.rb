require 'rails_helper'

RSpec.describe AvatarDeleter do
  describe '#call' do
    before :each do
      @user =  create(:user)
    end

    it "Deletes the user avatar image" do
      @params = { deleteImage: "1" }
      AvatarDeleter.call(@user, @params) 
      expect(@user.image.attached?).to be false
    end
  end
end
