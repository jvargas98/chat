class UserMailer < ApplicationMailer
default from: 'notifications@example.com'
  def updated_message
    @message = params[:message]
    @user = params[:user]
    @conversation = @message.conversation
    mail(to: @user.email, subject: 'A message has been updated')
  end
end
