require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "GET #show" do
    it "renders the show template if logged in" do
      u = FactoryBot.create(:user)
      get :activate, params: { activation_token: u.activation_token } 
      get :show, params: { id: u.id }
      expect(response).to render_template("show")
    end

    it "redirects to new session if not logged in" do
      u = FactoryBot.create(:user)
      get :show, params: { id: u.id }
      expect(response).to redirect_to(new_session_url)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post :create, params: { user: { email: '', password: ''} }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: { email: 'test@test.com', password: '12345' } }
        expect(response).to render_template("new")
        expect(flash[:errors].first).to include("too short")
      end
    end

    context "with valid params" do
      it "redirects user to bands index on success" do
        post :create, params: { user: { email: 'test@test.com', password: '123456' } }
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET #activate"
    context "with invalid params" do
      it "redirects to new sessions" do
        u = FactoryBot.create(:user)
        get :activate, params: { activation_token: "FAKE_TOKEN" }
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "with valid params" do
      it "redirects to user_url" do
        u = FactoryBot.create(:user)
        get :activate, params: { activation_token: u.activation_token }
        expect(response).to redirect_to(user_url(u.id))
      end
    end
end
