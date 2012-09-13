require 'spec_helper'

describe "developers/new" do
  before(:each) do
    assign(:developer, FactoryGirl.build(:developer))
  end

  it "renders new developer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => developers_path, :method => "post" do
      assert_select "input#developer_name", :name => "developer[name]"
      assert_select "input#developer_website", :name => "developer[website]"
      assert_select "select#developer_time_zone", :name => "developer[time_zone]"
      # todo only available if correct permission
      #assert_select "textarea#developer_address", :name => "developer[address]"
      #assert_select "textarea#developer_contact_information", :name => "developer[contact_information]"
    end
  end
end
