require 'rails_helper'

RSpec.describe MessagesController do
  let(:user) { create(:user_with_conversations) }
  let(:conversation) { user.conversations.first }
  let(:message) { create(:message, conversation_id: conversation.id, user_id: user.id ) }

  describe 'GET #index' do
    it 'renders the :index template' do
      sign_in user
      get :index, params: { conversation_id: conversation } 
      expect(response).to render_template :index
     end
  end

  describe 'GET #show' do
    it 'assign the requested message to @message' do
      sign_in user
      get :show, params: { id: message }, xhr: true
      expect(assigns(:message)).to eq message
    end

    it 'assign the requested message conversation to @conversation' do
      sign_in user
      get :show, params: { id: message }, xhr: true
      expect(assigns(:conversation)).to eq conversation
    end

    it "renders the :show template" do
      sign_in user
      get :show, params: { id: message }, xhr: true
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context "with valid attibutes" do
      it "saves the new Message in the database" do
        sign_in user
        expect{
          post :create, params: { message: attributes_for(:message, 
                                                          user_id: user.id, 
                                                          conversation_id: conversation.id),
                                  conversation_id: conversation.id}
        }.to change(Message, :count).by(1)
      end

      it "saves the new Message in the conversation" do
        sign_in user
        expect{
          post :create, params: { message: attributes_for(:message, 
                                                          user_id: user.id,
                                                          conversation_id: conversation.id),
                                  conversation_id: conversation.id}
        }.to change(conversation.messages, :count).by(1)
      end

      
      it "redirects to conversation#show" do
        sign_in user
          post :create, params: { message: attributes_for(:message, 
                                                          user_id: user.id,
                                                          conversation_id: conversation.id),
                                  conversation_id: conversation.id}
          expect(response).to redirect_to conversation_path(assigns[:conversation])
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new Message in the database" do
        sign_in user
        expect{
          post :create, params: { message: attributes_for(:message,
                                                          content: "",
                                                          user_id: user.id, 
                                                          conversation_id: conversation.id),
                                  conversation_id: conversation.id}
        }.not_to change(Message, :count)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, params: { message: attributes_for(:message,
                                                        content: "",
                                                        user_id: user.id, 
                                                        conversation_id: conversation.id),
                                conversation_id: conversation.id}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" 
      it 'locates the requested @message' do
        sign_in user
        patch :update, params: { id: message,
                                 message: attributes_for(:message, 
                                                        user_id: user.id, 
                                                        conversation_id: conversation.id) }
        expect(assigns(:message)).to eq(message)
      end

      it "changes @message's attributes" do
        sign_in user
        patch :update, params: { id: message,
                                 message: attributes_for(:message,
                                                         content: "New content",
                                                         user_id: user.id,
                                                         conversation_id: conversation.id) }
        message.reload
        expect(message.content).to eq('New content')
      end

      it "redirects to the updated message's conversation" do
        sign_in user
        patch :update, params: { id: message,
                                 message: attributes_for(:message,
                                                         content: "New content",
                                                         user_id: user.id,
                                                         conversation_id: conversation.id),
                                 conversation_id: conversation.id}
        expect(response).to redirect_to conversation_path(conversation.id)
      end

    context "with invalid attributes" do
      it 'does not update the message' do
        sign_in user
        patch :update, params: { id: message,
                                 message: attributes_for(:message,
                                                         content: "",
                                                         user_id: user.id,
                                                         conversation_id: conversation.id) }
        message.reload
        expect(message.content).not_to eq('')
      end

      it 'redirects to the root_path' do
        sign_in user
        patch :update, params: { id: message,
                                 message: attributes_for(:message,
                                                         content: "",
                                                         user_id: user.id,
                                                         conversation_id: conversation.id) }
        message.reload
        expect(response).to redirect_to root_path
        end
      end
  end

  describe 'DELETE #destroy' do
    it 'deletes the message from the database' do
      sign_in user
      patch :update, params: { id: message, message: {status: false }}
      message.reload
      expect(message.status).to eq(false)
    end

    it "redirects to the message's conversation path" do
      sign_in user
      patch :update, params: { id: message, message: {status: false }}
      message.reload
      expect(response).to redirect_to conversation_path(conversation.id)
    end
  end
end
