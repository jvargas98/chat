class AvatarAsignator < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
     @user.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.jpg')),
                      filename: 'default-avatar.jpg',
                      content_type: 'image/jpg')

     return true if @user.image.attached?
    false 
  end
end
