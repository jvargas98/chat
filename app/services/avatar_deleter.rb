class AvatarDeleter < ApplicationService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
     if @user.image.attached? && @params[:deleteImage] == "1"
      @user.image.purge
    end

     @user.image.purge
     @params.delete(:deleteImage)

     @user.update(@params)
     return true unless @user.image.attached?
    false 
  end
end
