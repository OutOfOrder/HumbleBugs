require 'spec_helper'

describe ConfirmAccountController do
  describe "GET 'confirm'" do
    before do
      @user = FactoryGirl.create :user, :confirm_account
    end
    it 'should assign the user to @user' do
      get :confirm, {id: @user.confirm_account_token}
      assigns(:user).should == @user
    end
    it 'should redirect to login url for valid confirm token' do
      get :confirm, {id: @user.confirm_account_token}
      response.should redirect_to login_url
    end
    it 'should NOT log in the user for a valid confirm token' do
      get :confirm, {id: @user.confirm_account_token}
      response.cookies['auth_token'].should eq(nil)
    end
    it 'should redirect to root on invalid token' do
      get :confirm, {id: 'bad_token'}
      response.should redirect_to root_url
    end
  end
end