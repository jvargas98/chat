require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    login_user
    it 'renders the :index template' do
      get :index, session: valid_session 
      expect(response).to render_template :index
      end
  end

  describe 'GET #show' do
    it 'assign the requested conversation to @conversation' do
      user = create(:user_with_conversations)
      sign_in user
      conversation = user.conversations.first
      get :show, params: { id: conversation }
      expect(assigns(:conversation)).to eq conversation
    end

    it "renders the :show template" do
      user = create(:user_with_conversations)
      sign_in user
      conversation = user.conversations.first
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
      user = create(:user_with_conversations)
      sign_in user
      conversation = user.conversations.first
      get :edit, params: { id: conversation }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before :each do
      @user = create(:user_with_conversations)
      @conversation = create(:conversation_with_users)
      sign_in @user
    end

    context "with valid attibutes" do
      it "saves the new Conversation in the database" do
        expect{
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: @conversation.users.ids)}
        }.to change(Conversation, :count).by(1)
      end
      
      it "creates a Room for each User in the conversation" do
        expect{
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: @conversation.users.ids)}
        }.to change(Room, :count).by(@conversation.users.ids.count + 1)
      end

      it "redirects to conversation#show" do
          post :create, params: { conversation: attributes_for(:conversation_with_users, 
                                                               user_ids: @conversation.users.ids)}
          expect(response).to redirect_to conversation_path(assigns[:conversation])
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new Conversation in the database" do
        expect{
          post :create,
          params: { conversation: attributes_for(:invalid_conversation, 
                    user_ids: @conversation.users.ids)}}
          .not_to change(Conversation, :count)
      end

      it "re-renders the :new template" do
        post :create,
        params: { conversation: attributes_for(:invalid_conversation, 
                  user_ids: @conversation.users.ids)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" do
      it 'updates the conversation in the database'
      it 'redirects to the conversation'
    end

    context "with invalid attributes" do
      it 'does not update the conversation'
      it 're-renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the conversation from the database'
    it 'redirects to the root path'
  end
end
