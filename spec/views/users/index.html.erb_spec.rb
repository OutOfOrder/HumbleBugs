require 'spec_helper'

describe "users/index" do
  before(:each) do
    @users = assign(:users, FactoryGirl.create_list(:user, 2))
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => /@example\.com/, :count => 2
    assert_select "tr>td", :text => @users.first.name, :count => 2
  end
end
