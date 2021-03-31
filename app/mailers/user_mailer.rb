class UserMailer < ApplicationMailer
default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def updated_message
    @message = params[:message]
    @user = params[:user]
    @conversation = @message.conversation
    mail(to: @user.email, subject: 'A message has been updated')
  end
end
