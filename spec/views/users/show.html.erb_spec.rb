require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/#{@user.email}/)
    rendered.should match(/Name/)
  end
end
