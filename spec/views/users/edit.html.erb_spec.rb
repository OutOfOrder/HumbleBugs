require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, FactoryGirl.build_stubbed(:user))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_password_digest", :name => "user[password_digest]"
    end
  end
end
