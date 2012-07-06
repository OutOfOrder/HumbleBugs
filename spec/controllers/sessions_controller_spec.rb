require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "should render the new login page" do
      get :new
      response.should render_template("new")
    end
  end

  describe "POST create" do
    before do
      @password = 'sw0rdf1sh'
      @user = FactoryGirl.create :user, :email => 'test@nowhere.com', :password => @password, :password_confirmation => @password
    end
    describe "with valid params" do
      it "log in the user" do
        post :create, {:email => @user.email, :password => @password}
        response.cookies['auth_token'].should eq(@user.auth_token)
      end

      it "redirects to the dashboard" do
        post :create, {:email => @user.email, :password => @password}
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "should not log in the user" do
        post :create, {:email => @user.email, :password => 'bad password'}

        response.cookies['auth_token'].should be_blank
      end

      it "re-renders the 'new' template" do
        post :create, {:email => @user.email, :password => 'bad password'}

        response.should render_template("new")
      end
    end

    describe "with mixed case emails" do
      before do
        @email = 'MixedCase@MySite.com'
        @user2 = FactoryGirl.create :user, :email => @email, :password => @password, :password_confirmation => @password
      end
      it "should log in of case is the same" do
        post :create, {:email => @email, :password => @password }

        response.cookies['auth_token'].should eq(@user2.auth_token)
      end

      it "should log in of case is not the same" do
        post :create, {:email => @email.downcase, :password => @password }

        response.cookies['auth_token'].should eq(@user2.auth_token)
      end
    end
  end

  describe "POST secret_login" do
    it 'logs in the user' do
      user = FactoryGirl.create :user
      post :secret_login, { :id => user.to_param}

      response.cookies['auth_token'].should eq(user.auth_token)
      session[:user].should === user
    end
  end
end
