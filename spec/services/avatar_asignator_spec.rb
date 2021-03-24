require 'rails_helper'

RSpec.describe AvatarAsignator do
  describe '#call' do
    before :each do
      @user =  create(:user)
    end

    it "Has a default avatar image attached to it" do
      expect(@user.image.attached?).to be true
    end

  end
end
