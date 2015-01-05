require 'spec_helper'

describe SessionsController do
  # actually /login
  describe "GET new" do
    it "should render the new login page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  # actually POST /login
  describe "POST create" do
    before do
      @password = 'sw0rdf1sh'
      @user = FactoryGirl.create :user, :confirmed, :email => 'test@nowhere.com', :password => @password, :password_confirmation => @password
    end
    describe "with valid params" do
      it "log in the user" do
        post :create, {:email => @user.email, :password => @password}
        expect(response.cookies['auth_token']).to eq(@user.auth_token)
      end

      it "redirects to the dashboard" do
        post :create, {:email => @user.email, :password => @password}
        expect(response).to redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "should not log in the user" do
        post :create, {:email => @user.email, :password => 'bad password'}

        expect(response.cookies['auth_token']).to be_blank
      end

      it "re-renders the 'new' template" do
        post :create, {:email => @user.email, :password => 'bad password'}

        expect(response).to render_template("new")
      end
    end

    describe "with mixed case emails" do
      before do
        @email = 'MixedCase@MySite.com'
        @user2 = FactoryGirl.create :user, :confirmed, :email => @email, :password => @password, :password_confirmation => @password
      end
      it "should log in of case is the same" do
        post :create, {:email => @email, :password => @password }

        expect(response.cookies['auth_token']).to eq(@user2.auth_token)
      end

      it "should log in of case is not the same" do
        post :create, {:email => @email.downcase, :password => @password }

        expect(response.cookies['auth_token']).to eq(@user2.auth_token)
      end
    end
  end

  describe "POST secret_login" do
    it 'should not be available in production' do
      allow(Rails).to receive_messages(env: ActiveSupport::StringInquirer.new("production"))
      user = FactoryGirl.create :user
      post :secret_login, { id: user.to_param }
      expect(response.cookies['auth_token']).not_to eq(user.auth_token)
      expect(response.code).to eq("500")
    end
    it 'logs in the user' do
      user = FactoryGirl.create :user
      post :secret_login, { :id => user.to_param}

      expect(response.cookies['auth_token']).to eq(user.auth_token)
      expect(session[:user_id]).to be === user.id
    end
  end

  # actually /logout
  describe "GET destroy" do
    it 'should delete the auth token on logout' do
      user = FactoryGirl.create :user

      request.cookies['auth_token'] = user.auth_token
      get_with user, :destroy

      expect(response.cookies['auth_token']).to be_nil
    end
  end
end
