require 'rails_helper'

RSpec.describe MessageDeleter do
  describe '#call' do
    before :each do
      @message =  create(:message)
    end

    it "Soft deletes the message" do
      @params = { status: false, deleteImage: "1" }
      MessageDeleter.call(@message, @params) 
      expect(@message.alive?).to be false
    end

    it "removes the image from the message" do
      @params = { status: false, deleteImage: "1" }
      MessageDeleter.call(@message, @params) 
      expect(@message.image.attached?).to be false
    end
  end
end
