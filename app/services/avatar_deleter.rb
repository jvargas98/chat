class AvatarDeleter < ApplicationService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.image.purge if @user.image.attached? && (@params[:deleteImage] == "1")

    @params.delete(:deleteImage)

    @user.update(@params)
    return true unless @user.image.attached?
   false 
  end
end
