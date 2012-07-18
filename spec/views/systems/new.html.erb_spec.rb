require 'spec_helper'

describe "systems/new" do
  before(:each) do
    @system = assign(:system, FactoryGirl.build(:system))
    @user = assign(:user, @system.user)
  end

  it "renders new system form" do
    render

    assert_select "form", :action => user_systems_path(@user), :method => "post" do
      assert_select "input#system_name", :name => "system[name]"
      assert_select "textarea#system_description", :name => "system[description]"
      assert_select "input#system_operating_system", :name => "system[operating_system]"
      assert_select "input#system_processor", :name => "system[processor]"
      assert_select "input#system_graphics_card", :name => "system[graphics_card]"
      assert_select "input#system_graphics_driver", :name => "system[graphics_driver]"
    end
  end
end
