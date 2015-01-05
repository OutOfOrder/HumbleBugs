require 'spec_helper'

describe PasswordResetController do
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
    it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "GET 'create'" do
    before do
      @user = FactoryGirl.create :user
    end
    describe "with valid params" do
      it "redirects to the root page" do
        post :create, {email: @user.email}
        expect(response).to redirect_to root_url
      end
      it "should call send_password_reset on the matched user" do
        expect_any_instance_of(User).to receive(:send_password_reset)
        post :create, {email: @user.email}
      end
      it "builds and delivers the password_reset email" do
        mailer = double("UserMailer")
        expect(mailer).to receive(:deliver)
        expect(UserMailer).to receive(:password_reset).
            with(@user).
            and_return(mailer)

        post :create, {email: @user.email}
      end
    end
    describe "with unknown email" do
      it "redirects to the root page" do
        post :create, {email: "bad@example.com"}
        expect(response).to redirect_to root_url
      end
    end
    describe "with blank email" do
      it "redirects to the forgot password page" do
        post :create, {email: ""}
        expect(response).to redirect_to forgot_password_url
      end
    end
    describe "with mixed case emails" do
      before do
        @email = 'MixedCase@MySite.com'
        @user2 = FactoryGirl.create :user, :confirmed, :email => @email
      end
      it "should find the user and send the email" do
        expect_any_instance_of(User).to receive(:send_password_reset)
        post :create, {email: @user.email}
      end

      it "should find the user and send the email if the case is not the same" do
        expect_any_instance_of(User).to receive(:send_password_reset)
        post :create, {email: @user.email.downcase}
      end
    end
  end

  describe "GET edit" do
    before do
      @user = FactoryGirl.create(:user, :password_reset)
    end

    it "assigns the matched user as @user" do
      get :edit, {id: @user.password_reset_token}
      expect(assigns(:user)).to eq(@user)
    end
    it "should render the edit template" do
      get :edit, {id: @user.password_reset_token}
      expect(response).to render_template("edit")
    end
    it "should return http success" do
      get :edit, {id: @user.password_reset_token}
      expect(response).to be_success
    end
  end

  describe "PUT update" do
    before do
      @password = 'Sw0rdf1sh'
    end
    describe "with valid params" do
      before do
        @user = FactoryGirl.create(:user, :password_reset)
        @base_params = {id: @user.password_reset_token, user: {password: @password, password_confirmation: @password}}
      end

      it "assigns the requested user as @user" do
        put :update, @base_params
        expect(assigns(:user)).to eq(@user)
      end

      it "should change the users password" do
        expect {
          put :update, @base_params
        }.to change(@user, :password_digest)
      end
      it "redirects to the login page" do
        put :update, @base_params
        expect(response).to redirect_to(login_url)
      end
    end

    describe "with an expired reset token" do
      it "should redirect to new reset password page" do
        user = FactoryGirl.create :user, :password_reset, password_reset_sent_at: 4.hours.ago
        put :update, {id: user.password_reset_token, user: {password: @password, password_confirmation: @password}}
        expect(response).to redirect_to(forgot_password_url)
      end
    end

    describe "with mismatched passwords" do
      it "should be have an error" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: @password, password_confirmation: 'test22'}}
        expect(assigns(:user).errors[:password].size).to be >= 1
      end
      it "should re-render the edit template" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: @password, password_confirmation: 'test22'}}
        expect(response).to render_template("edit")
      end
    end
    describe "with no new password entered" do
      it "should be have an error on password" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: "", password_confirmation: ""}}
        expect(assigns(:user).errors.messages).to include(password: ["can't be blank"])
      end
      it "should re-render the edit template" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: "", password_confirmation: ""}}
        expect(response).to render_template("edit")
      end
    end
    describe "with no new password confirmation  entered" do
      it "should be have an error on password confirmation" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: "test", password_confirmation: ""}}
        expect(assigns(:user).errors[:password_confirmation].size).to eq(1)
      end
      it "should re-render the edit template" do
        user = FactoryGirl.create :user, :password_reset
        put :update, {id: user.password_reset_token, user: {password: "test", password_confirmation: ""}}
        expect(response).to render_template("edit")
      end
    end
    describe "with invalid params" do
      it "assigns the user as @user" do
        user = FactoryGirl.create(:user, :password_reset)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put :update, {id: user.password_reset_token}
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = FactoryGirl.create(:user, :password_reset)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put :update, {id: user.password_reset_token}
        expect(response).to render_template("edit")
      end
    end
  end
end
