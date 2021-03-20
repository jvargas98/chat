class MessageDeleter < ApplicationService
  def initialize(message, params)
    @message = message
    @params = params
  end

  def call
    @message.image.purge if @message.image.attached? && (@params[:deleteImage] == "1")

    @params.delete(:deleteImage)

    return true if @message.update(@params)
    false 
  end
end
