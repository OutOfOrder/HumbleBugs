require 'spec_helper'

describe "bundles/new" do
  before(:each) do
    assign(:bundle, stub_model(Bundle,
      :name => "MyString",
      :description => "MyText",
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new bundle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bundles_path, :method => "post" do
      assert_select "input#bundle_name", :name => "bundle[name]"
      assert_select "textarea#bundle_description", :name => "bundle[description]"
      assert_select "input#bundle_state", :name => "bundle[state]"
    end
  end
end
