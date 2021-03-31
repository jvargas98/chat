require 'rails_helper'

RSpec.describe ConversationsController do
  let(:user) { create(:user_with_conversations) }
  let(:conversation) { user.conversations.first }

  describe 'GET #index' do
    login_user
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
      end
  end

  describe 'GET #show' do
    it 'assign the requested conversation to @conversation' do
      sign_in user
      get :show, params: { id: conversation }
      expect(assigns(:conversation)).to eq conversation
    end

    it "renders the :show template" do
      sign_in user
      get :show, params: { id: conversation }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    login_user
    it "assigns a new Conversation to @conversation" do
      get :new
      expect(assigns(:conversation)).to be_a_new(Conversation)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end
  
  describe 'GET #edit' do
    it "renders the :edit template" do
      sign_in user
      get :edit, params: { id: conversation }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    let(:conversation_with_users) { create(:conversation_with_users) }

    context "with valid attibutes" do
      it "saves the new Conversation in the database" do
        sign_in user
        expect{
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: conversation.users.ids)}
        }.to change(Conversation, :count).by(1)
      end
      
      it "creates a Room for each User in the conversation" do
        sign_in user
        expect{
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: conversation.users.ids)}
        }.to change(Room, :count).by(conversation.users.ids.count + 1)
      end

      it "redirects to conversation#show" do
        sign_in user
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: conversation.users.ids)}
          expect(response).to redirect_to conversation_path(assigns[:conversation])
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new Conversation in the database" do
        sign_in user
        expect{
          post :create,
          params: { conversation: attributes_for(:invalid_conversation, 
                    user_ids: conversation.users.ids)}}
          .not_to change(Conversation, :count)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create,
        params: { conversation: attributes_for(:invalid_conversation, 
                  user_ids: conversation.users.ids)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" do
      it 'locates the requested @conversation' do
        sign_in user
        patch :update, params: { id: conversation,
                                 conversation: attributes_for(:conversation_with_users,
                                 user_ids: conversation.users.ids) }
        expect(assigns(:conversation)).to eq(conversation)
      end

      it "changes @conversation's attributes" do
        sign_in user
        patch :update, params: { id: conversation,
          conversation: attributes_for(:conversation_with_users,
                                       name: "New conver name") }
        conversation.reload
        expect(conversation.name).to eq('New conver name')
      end

      it "redirects to the updated conversation" do
        sign_in user
        patch :update, params: { id: conversation, 
                                 conversation: attributes_for(:conversation_with_users) }
        expect(response).to redirect_to conversation
      end
    end

    context "with invalid attributes" do
      it 'does not update the conversation' do 
        sign_in user
        patch :update, params: { id: conversation, 
                                 conversation: attributes_for(:conversation_with_users,
                                 name:"", status: "")}
        conversation.reload
        expect(conversation.name).not_to eq("")
        expect(conversation.status).not_to eq("")
      end

      it 're-renders the :edit template' do
        sign_in user
        patch :update, params: { id: conversation, 
                                 conversation: attributes_for(:invalid_conversation)}
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the conversation from the database' do
      sign_in user
      conversation
      expect{
        delete :destroy, params: { id: conversation }}.to change(Conversation, :count).by(-1)
    end

    it 'redirects to the root path' do
      sign_in user
      delete :destroy, params: { id: conversation }
      expect(response).to redirect_to root_path
    end
  end
end
