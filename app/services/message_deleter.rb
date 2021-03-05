class MessageDeleter < ApplicationService
  def initialize(message, params)
    @message = message
    @params = params
  end

  def call
    if @message.image.attached? && @params[:deleteImage] == "1"
      @message.image.purge
    end

    @params.delete(:deleteImage)

    return true if @message.update(@params)
    false 
  end
end
