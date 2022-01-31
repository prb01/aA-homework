require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest).with_message("Password can't be blank") }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "class methods" do
    context "#is_password?" do
      it "should return true if password matches" do
        expect(FactoryBot.build(:user).is_password?("password")).to eq(true)
      end

      it "should return false if password does not match" do
        expect(FactoryBot.build(:user).is_password?("1234")).to eq(false)
      end
    end

    context "#reset_session_token!" do
      let(:u) { FactoryBot.build(:user) }

      it "generates a new session token" do
        token = u.session_token
        u.reset_session_token!
        expect(u.session_token).not_to eq(token)
      end

      it "saves session token to database" do
        u.reset_session_token!
        token = u.session_token
        expect(User.find_by(id: u.id).session_token).to eq(token)
      end
    end

    context "::find_by_credentials" do
      let(:u) { FactoryBot.create(:user) }

      it "returns user if email & password match" do
        expect(User.find_by_credentials(email: u.email, password: u.password))
          .to be_a(User)
      end
      
      it "returns nil if email does not match" do
        expect(User.find_by_credentials(email: "bla@bla.com", password: u.password))
          .to be_nil
      end

      it "returns nil if password does not match" do
        expect(User.find_by_credentials(email: u.email, password: "blabla"))
          .to be_nil
      end
    
    end

  end
end
