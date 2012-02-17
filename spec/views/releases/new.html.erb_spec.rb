require 'spec_helper'

describe "releases/new" do
  before(:each) do
    assign(:release, stub_model(Release,
      :notes => "MyText",
      :owner => nil,
      :game => nil,
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => releases_path, :method => "post" do
      assert_select "textarea#release_notes", :name => "release[notes]"
      assert_select "input#release_owner", :name => "release[owner]"
      assert_select "input#release_url", :name => "release[url]"
    end
  end
end
